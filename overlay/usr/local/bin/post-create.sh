#!/bin/sh

SCM_REPO_PATH=$1
SCM_TYPE=$2
SCM_PROJECT=$3

SCM_REPO_NAME=$(basename $SCM_REPO_PATH)
SCM_REPO_ROOT=$(dirname $SCM_REPO_PATH)

case "$SCM_TYPE" in
    svn)
        HOOK_SCRIPT=$SCM_REPO_PATH/hooks/post-commit
        echo "#!/bin/sh" > $HOOK_SCRIPT
        echo "" >> $HOOK_SCRIPT
        echo /usr/local/bin/update_repo $SCM_PROJECT >> $HOOK_SCRIPT
        chmod a+x $HOOK_SCRIPT
        ;;
    git)
        HOOK_SCRIPT=$SCM_REPO_PATH/hooks/post-receive
        echo "#!/bin/sh" > $HOOK_SCRIPT
        echo "" >> $HOOK_SCRIPT
        echo /usr/local/bin/update_repo $SCM_PROJECT >> $HOOK_SCRIPT
        chmod a+x $HOOK_SCRIPT
        ;;
    mercurial)
        HGRC=$SCM_REPO_PATH/.hg/hgrc
        echo [hooks] > $HGRC
        echo changegroup = /usr/local/bin/update_repo $SCM_PROJECT >> $HGRC
        ;;
    bazaar)
        ;;
    *)
        echo "SCM not supported: $SCM_TYPE" >&2
        ;;
esac

exit 0
