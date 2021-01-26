Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90758C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BA522B3B
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbhAZRTd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389149AbhAZGpa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:45:30 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF5FC061573
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:44:50 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z22so11567978qto.7
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fKh9IX10ZNTPUcknvIN66hOYlFOSEX+HxhLysCGV/o=;
        b=N/ESG6B3X0l8uXRmOM7S2geAjrru93V6y8FKbeVNhgDAtC/1ghNqIQGKSXdQQr9n6h
         yT8wBQe9uYsV80m928X/nZC1pPfo1djqSQb/GUBqPlQNUSwgbVD3J6CNKz0bUPLXfUDs
         qepleKG9VELRZ13lIbD7IYEpAWH3E3v5JnbIatiK43OSlr0FHjKZK3oPE55wtxGeF8+V
         Bzfuct0xxE2navzuxRjmNP+ICsCJeXyxXcS3OnvBBZgUmcZd4nwn9DNBZNAEjQhOu9uG
         tZbOmlmdfBswl3Wmh3+3RAFzyrffiM3/Xt10vrHPYrwutg0xG2BrETUs4jqTTJRfMHXe
         btpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9fKh9IX10ZNTPUcknvIN66hOYlFOSEX+HxhLysCGV/o=;
        b=FV8RHnNktaL0/ipDwBEdUu9scUWx83dHlJv+xiqBmAoQi+PCcNtQGSB1QR0J/QB1W/
         DOZmAJG0OoTqgvZhCjVAFRks6d36J9INPU9gsA+usbE0mXW0F6N7mT1JZK2LVGGQHl0L
         p6yIAVUJmRDMd5XnCYqut5giQvI3qF1bgaiHDLSbNKqfVU0rcIjPK+yXSLmuxDRVEZPr
         67TsDdECdvBhIJwX3aShiqyHPptHi3uWadOQixYoXrvHKR3tmVljsHeIP5vBDW1ImFeI
         H5EHzqmBve1J0qET+0lVthE1rwVg33XMdJHwxPhUTf8MtBONljmXovdpNVoD41jk3w7f
         oqww==
X-Gm-Message-State: AOAM533svk2RSENrRhMAqbNIOUt1SAd4ZGJRmmuCKRvltHLNrq/aCUaz
        Zrwtv0iJGhgCa7LftH6Kq5EwKKxJnee7QQ==
X-Google-Smtp-Source: ABdhPJwXYn98fvlTBfaT/YjEFvDRoIDgLIw/b4nuemFnLqwpicEiEDh4rKwkIPMKJmGk1Kv5i+9LXg==
X-Received: by 2002:ac8:7c95:: with SMTP id y21mr3976697qtv.199.1611643489428;
        Mon, 25 Jan 2021 22:44:49 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id o187sm13918278qkd.70.2021.01.25.22.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:44:49 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: rm scripts/do-git-push
Date:   Tue, 26 Jan 2021 01:44:38 -0500
Message-Id: <20210126064438.23660-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove this old script for maintaining rt-tests.
I have some new scripts that do this kind of thing that I maintain
out of tree, which I think is more appropriate anyway.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 scripts/do-git-push | 115 --------------------------------------------
 1 file changed, 115 deletions(-)
 delete mode 100755 scripts/do-git-push

diff --git a/scripts/do-git-push b/scripts/do-git-push
deleted file mode 100755
index 1530d1001c49..000000000000
--- a/scripts/do-git-push
+++ /dev/null
@@ -1,115 +0,0 @@
-#!/bin/sh
-#
-# script to automate pushing rt-tests tarball and git branch to
-# kernel.org.
-#
-# This won't work if you aren't me :)
-#
-#   Copyright 2009 Clark Williams <williams@redhat.com>
-#
-
-testing=0
-TEMP=$(getopt -o t -l test -n do-git-push -- "$@")
-if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
-eval set -- "$TEMP"
-while true; do
-    case "$1" in
-	-t|--test) testing=1 ; shift ;;
-	--) shift ; break ;;
-	*) echo "Internal Error!"; exit 1 ;;
-    esac
-done
-
-if [ $# -lt 1 ]
-then
-    echo "usage: do-git-push <version>"
-    exit -1
-fi
-
-version=$1
-accnt=clrkwllms@master.kernel.org
-destpath=/pub/linux/kernel/people/clrkwllms/
-branch=$(git symbolic-ref -q HEAD)
-
-if [ $testing -eq 1 ]; then
-    echo "version:  $version"
-    echo "accnt:    $accnt"
-    echo "destpath: $destpath"
-    echo "branch:   $branch"
-fi
-
-# sanity check
-if [ ! -d .git ]
-then
-    echo "No .git directory found!"
-    echo "cwd: $(pwd)"
-    exit -1
-fi
-
-# make sure we're on the master branch
-if [ $branch != 'refs/heads/master' ]; then
-   echo "must be on master branch to push!"
-   echo "(currently on branch: $branch)"
-   exit -1
-fi
-
-# double sanity check
-mkver=$(awk '$1 == "VERSION_STRING" {print $3; exit 0}' Makefile)
-if [ $version != $mkver ]
-then
-    echo "parameter mismatch with Makefile!"
-    echo "input parameter:  $version"
-    echo "Makefile version: $mkver"
-    exit -1
-fi
-
-# check the git tag
-tag="v$version"
-if rev=$(git rev-parse --verify -q "$tag")
-then
-	if [ "tag" = "$(git cat-file -t $rev)" ]; then
-		echo "using existing tag $tag"
-	else
-		echo "$tag is not a tag"
-		exit -1
-	fi
-else
-	echo "Generating annotated tag $tag"
-	if [ $testing -eq 0 ]; then
-	    git tag -a $tag
-	    if [ $? != 0 ]; then
-		echo "No tag message; aborting!"
-		exit -1
-	    fi
-	else
-	    echo "testing: Generate Tag"
-	fi
-fi
-
-# copy the tarball if it isn't already there
-tar=rt-tests-$version.tar.gz
-asc=rt-tests-$version.tar.asc
-
-if [ ! -e $tar ];
-then
-    echo "Generating tarfile $tar"
-    make release
-else
-    echo "Using existing tarfile $tar"
-fi
-
-if kup ls $destpath | grep $tar > /dev/null 2>&1
-then
-    echo "Tarfile $tar is already on kernel.org"
-else
-    echo "Copying tarfile $tar to kernel.org"
-    if [ $testing -eq 0 ]; then
-	kup put $tar $asc $destpath/$tar
-    else
-	echo "testing: copy tarfile"
-    fi
-fi
-
-[ $testing -eq 1 ] && dryrun=--dry-run
-echo "Pushing master and tags to kernel.org"
-git push $dryrun --tags origin master
-- 
2.26.2

