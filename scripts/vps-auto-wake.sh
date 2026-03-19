#!/bin/bash
# VPS auto-wake: Check if Mac inactive, take over if needed

WORKSPACE=/root/.openclaw/workspace
HANDOVER_FILE=$WORKSPACE/HANDOVER.md
HANDOVER_JSON=$WORKSPACE/HANDOVER_STATE.json
ACTIVE_AGENT=$WORKSPACE/.active-agent
LAST_HANDOVER_TIME=/tmp/last_handover_check.txt

echo "VPS wake check..."
echo "Reading VPS instructions..."

# 0. Read VPS instructions (know what to do)
if [ -f $WORKSPACE/scripts/VPS-CHIPPY-INSTRUCTIONS.md ]; then
    echo "VPS instructions found. Reviewing role..."
    cat $WORKSPACE/scripts/VPS-CHIPPY-INSTRUCTIONS.md | head -80
fi

# 1. Pull latest from git
cd $WORKSPACE
git pull --quiet 2>&1

# 2. Check active agent
if [ -f $ACTIVE_AGENT ]; then
    ACTIVE=$(cat $ACTIVE_AGENT)
    
    if [ "$ACTIVE" = "vps" ]; then
        echo "VPS should be active. Checking handover..."
        
        # 3. Read handover if exists
        if [ -f $HANDOVER_FILE ]; then
            echo "Handover found:"
            cat $HANDOVER_FILE
            echo ""
        fi
        
        if [ -f $HANDOVER_JSON ]; then
            echo "Handover state:"
            cat $HANDOVER_JSON
            echo ""
        fi
        
        # 4. Log wake time
        echo "$(date -Iseconds)" > $LAST_HANDOVER_TIME
        
        echo "VPS Chippy active and ready."
    else
        echo "Mac is active ($ACTIVE). Standing by."
    fi
else
    echo "No active agent marker. Creating (vps)..."
    echo "vps" > $ACTIVE_AGENT
    git add .active-agent 2>/dev/null
    git commit -m "init: active agent marker" 2>/dev/null
    git push 2>/dev/null
fi

echo "VPS wake check complete."
