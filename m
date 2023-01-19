Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3DBC004D4
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Jan 2023 21:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjASVYt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 16:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjASVWo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Jan 2023 16:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23DA4DCE0
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2023 13:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674162931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMg8gNQDfp59Z8c/Laiz+GjWJb2Q7J01BdsOGckaZ2o=;
        b=UpC/KpUDpEMYCS5+V9Fr8jl0r/Xo7A/XnUk+plLkz8t+bk1JRgj6RuI42vM5E0zdTw3ATt
        3Qjw3/vNjdCukcjHR0mf7gnoDgAq6wsXOcgzGK++8Fda0ZNm/FGW6FMbfO/2bLInAAsnHw
        OuEmCshJZvfDpyCD1FWhLhx6ueQX4ZQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-355-2GKVySY3MIWGcTXfTztjiQ-1; Thu, 19 Jan 2023 16:15:30 -0500
X-MC-Unique: 2GKVySY3MIWGcTXfTztjiQ-1
Received: by mail-qt1-f197.google.com with SMTP id c18-20020ac84e12000000b003b5d38f1d29so1552160qtw.0
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2023 13:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMg8gNQDfp59Z8c/Laiz+GjWJb2Q7J01BdsOGckaZ2o=;
        b=X7iV/akTfMfKFR8XjpE3m8nukx7zMcgpnkR+jhQunkOv768KO709z5I6HUt5eJhZmF
         DRmbeYInSSmIvYFHV6xyodRekF7SlIX4USxvL2cWL2uQTtroa4gplYsYQwVd9JNcOXW3
         /ZfWalEEsqIZ7Tqn84PkxavV6W7WG9kh6DogUOXuHn699X3qNrLFbDdc+tjDzRMsWTRa
         jR/3UwEMRc3pUQDhusZM+R4y1QRMg9GI4WjDGt9i/3iJx8M9F+gw0ihoNixfDDi/1sXQ
         8rnXs++Y3Nyyttuqcw/us/NNK54Y5q35w5xWfayyyJEBxRySaHBSUBMsDBDKicZwO40G
         eQ8Q==
X-Gm-Message-State: AFqh2kpcs1sjnw1XlJDtfZchY/ayAZVwDxmBDzFTn92q4hOPRog+WFsY
        STFjMKRle6lvvGd3tD+xoshe5SpQbQscfsaAf4abdLlMivhdI2rf7e3PI3l4avPqHSDcr0aOFqu
        qsEhGQtZFZ4KMZnUT0CB7qbFRFx4=
X-Received: by 2002:ac8:45ce:0:b0:3b6:2e75:c9bd with SMTP id e14-20020ac845ce000000b003b62e75c9bdmr14633626qto.1.1674162929632;
        Thu, 19 Jan 2023 13:15:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvg7Cqm+RqOllnoGepwIah3wOQ0QFEfc8gtV8SZaGb8UPTC0/BLnk7Faj89h/7LOb3Hkn2f0w==
X-Received: by 2002:ac8:45ce:0:b0:3b6:2e75:c9bd with SMTP id e14-20020ac845ce000000b003b62e75c9bdmr14633616qto.1.1674162929441;
        Thu, 19 Jan 2023 13:15:29 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86798000000b0039cc944ebdasm19443699qtp.54.2023.01.19.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:15:29 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>
Subject: [RFC PATCH RESEND 1/1] fs/namespace: defer free_mount from namespace_unlock
Date:   Thu, 19 Jan 2023 16:14:55 -0500
Message-Id: <20230119211455.498968-2-echanude@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211455.498968-1-echanude@redhat.com>
References: <20230119211455.498968-1-echanude@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Alexander Larsson <alexl@redhat.com>

Use call_rcu to defer releasing the umount'ed or detached filesystem
when calling namepsace_unlock().

Calling synchronize_rcu_expedited() has a significant cost on RT kernel
that default to rcupdate.rcu_normal_after_boot=1.

For example, on a 6.2-rt1 kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
           0.07464 +- 0.00396 seconds time elapsed  ( +-  5.31% )

With this change applied:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
        0.00162604 +- 0.00000637 seconds time elapsed  ( +-  0.39% )

Waiting for the grace period before completing the syscall does not seem
mandatory. The struct mount umount'ed are queued up for release in a
separate list and no longer accessible to following syscalls.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 fs/namespace.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab467ee58341..11d219a6e83c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -44,6 +44,11 @@ static unsigned int m_hash_shift __read_mostly;
 static unsigned int mp_hash_mask __read_mostly;
 static unsigned int mp_hash_shift __read_mostly;
 
+struct mount_delayed_release {
+	struct rcu_head rcu;
+	struct hlist_head release_list;
+};
+
 static __initdata unsigned long mhash_entries;
 static int __init set_mhash_entries(char *str)
 {
@@ -1582,11 +1587,31 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
-static void namespace_unlock(void)
+static void free_mounts(struct hlist_head *mount_list)
 {
-	struct hlist_head head;
 	struct hlist_node *p;
 	struct mount *m;
+
+	hlist_for_each_entry_safe(m, p, mount_list, mnt_umount) {
+		hlist_del(&m->mnt_umount);
+		mntput(&m->mnt);
+	}
+}
+
+static void delayed_mount_release(struct rcu_head *head)
+{
+	struct mount_delayed_release *drelease =
+		container_of(head, struct mount_delayed_release, rcu);
+
+	free_mounts(&drelease->release_list);
+	kfree(drelease);
+}
+
+static void namespace_unlock(void)
+{
+	struct hlist_head head;
+	struct mount_delayed_release *drelease;
+
 	LIST_HEAD(list);
 
 	hlist_move_list(&unmounted, &head);
@@ -1599,12 +1624,15 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
 
-	synchronize_rcu_expedited();
-
-	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
-		hlist_del(&m->mnt_umount);
-		mntput(&m->mnt);
+	drelease = kmalloc(sizeof(*drelease), GFP_KERNEL);
+	if (unlikely(!drelease)) {
+		synchronize_rcu_expedited();
+		free_mounts(&head);
+		return;
 	}
+
+	hlist_move_list(&head, &drelease->release_list);
+	call_rcu(&drelease->rcu, delayed_mount_release);
 }
 
 static inline void namespace_lock(void)
-- 
2.39.0

