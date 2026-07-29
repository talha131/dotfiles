# Completions for `myws` (see fish/functions/myws.fish).

function __myws_workspaces --description 'List cmux workspace refs for completion'
    cmux workspace list --json 2>/dev/null | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
for w in d.get("workspaces", []):
    ref = w.get("ref")
    name = w.get("custom_title") or w.get("title") or ""
    if ref:
        print(f"{ref}\t{name}")
'
end

# First argument: the state.
complete -c myws -f -n 'test (count (commandline -opc)) -eq 1' -a done     -d 'Green ✓ Done pill'
complete -c myws -f -n 'test (count (commandline -opc)) -eq 1' -a active   -d 'Blue ⚡ Active pill (like Running)'
complete -c myws -f -n 'test (count (commandline -opc)) -eq 1' -a deferred -d 'Gray ⏸ Deferred pill'
complete -c myws -f -n 'test (count (commandline -opc)) -eq 1' -a clear    -d 'Remove the pill'
complete -c myws -f -n 'test (count (commandline -opc)) -eq 1' -a status   -d 'Show pills + lifecycle lane'

# Second argument: optional workspace ref.
complete -c myws -f -n 'test (count (commandline -opc)) -eq 2' -a '(__myws_workspaces)'
