Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D721C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 01:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356046128A
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 01:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhJEBxA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 21:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhJEBw7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Oct 2021 21:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633398669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3LQcRwG4XscAS00eRkwfICipH9ymt1VU5AraTgd4k/k=;
        b=Xms8XSt/0wyzsMM5dhBM9oQk0v1BQmQiXfKkx3AdtXYQtN02iYG53dxXXgYR9PfprobRYe
        GtpS47qpJaN3DQO/iIUm9xhuqx2rAsZ1NdjTS7T0CvbTMXj03Acr6U+FE7tnxxq+V7gpkV
        slmZgGFDph4Ww3lB9e3TYnurFyRGOKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-SI1TMALqN7qMZpUx6hKNWQ-1; Mon, 04 Oct 2021 21:51:08 -0400
X-MC-Unique: SI1TMALqN7qMZpUx6hKNWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A708218D6A2A;
        Tue,  5 Oct 2021 01:51:07 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.11.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C1729AA38;
        Tue,  5 Oct 2021 01:51:07 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 9980A3C0205; Mon,  4 Oct 2021 22:51:05 -0300 (-03)
Date:   Mon, 4 Oct 2021 22:51:05 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Pei Zhang <pezhang@redhat.com>
Subject: [RFC RT v5.10] [rt] repair usage of dev_base_lock in netstat_show()
Message-ID: <YVuviZ3F7MbPvleo@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Avoid a possible circular locking dependency by taking the softirq_ctrl.lock
before taking dev_base_lock in netstat_show(), keeping locking order
consistent.

Lockdep splat:

[  106.529733] ======================================================
[  106.529734] WARNING: possible circular locking dependency detected
[  106.529734] 5.10.65-rt53+ #1 Tainted: G        W I      
[  106.529736] ------------------------------------------------------
[  106.529736] tuned/2760 is trying to acquire lock:
[  106.529737] ffffa0695ea18220 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip+0x116/0x2f0
[  106.529746] 
               but task is already holding lock:
[  106.529746] ffffffff844af760 (dev_base_lock){++.+}-{0:0}, at: netstat_show.isra.17+0x4a/0xb0
[  106.529752] 
               which lock already depends on the new lock.
...
[  106.529825] 
               other info that might help us debug this:

[  106.529826]  Possible unsafe locking scenario:

[  106.529826]        CPU0                    CPU1
[  106.529827]        ----                    ----
[  106.529827]   lock(dev_base_lock);
[  106.529828]                                lock((softirq_ctrl.lock).lock);
[  106.529829]                                lock(dev_base_lock);
[  106.529829]   lock((softirq_ctrl.lock).lock);
[  106.529830] 
                *** DEADLOCK ***

[  106.529831] 6 locks held by tuned/2760:
[  106.529832]  #0: ffffa062296a6670 (&f->f_pos_lock){+.+.}-{0:0}, at: __fdget_pos+0x4b/0x60
[  106.529836]  #1: ffffa062223ae310 (&p->lock){+.+.}-{0:0}, at: seq_read_iter+0x56/0x420
[  106.529839]  #2: ffffa06242ea1ab8 (&of->mutex){+.+.}-{0:0}, at: kernfs_seq_start+0x28/0x90
[  106.529842]  #3: ffffa06268f52008 (kn->active#285){++++}-{0:0}, at: kernfs_seq_start+0x30/0x90
[  106.529844]  #4: ffffffff844af760 (dev_base_lock){++.+}-{0:0}, at: netstat_show.isra.17+0x4a/0xb0
[  106.529848]  #5: ffffffff840c8fa0 (rcu_read_lock){....}-{1:2}, at: rt_read_lock+0x7d/0x1e0


Reported-by: Pei Zhang <pezhang@redhat.com>
Signed-off-by: Nitesh Narayan Lal <nilal@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 net/core/net-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index f6197774048b..7291ca052632 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -625,14 +625,14 @@ static ssize_t netstat_show(const struct device *d,
 	WARN_ON(offset > sizeof(struct rtnl_link_stats64) ||
 		offset % sizeof(u64) != 0);
 
-	read_lock(&dev_base_lock);
+	read_lock_bh(&dev_base_lock);
 	if (dev_isalive(dev)) {
 		struct rtnl_link_stats64 temp;
 		const struct rtnl_link_stats64 *stats = dev_get_stats(dev, &temp);
 
 		ret = sprintf(buf, fmt_u64, *(u64 *)(((u8 *)stats) + offset));
 	}
-	read_unlock(&dev_base_lock);
+	read_unlock_bh(&dev_base_lock);
 	return ret;
 }
 

