Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317BBC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 01:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 135D7610A3
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 01:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhJEBzE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 21:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229744AbhJEBzC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Oct 2021 21:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633398792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zlsD/e+545hm1U8kFACaNgFTiOKxBqHK9Z+3be7TFQ4=;
        b=e7ZyT1u1lDJANQYeqAlebizwnjNXYD3gXz0K25Xe0XlQoKvE3RruZPT8di7/TZnJCxw7iK
        4cBImrXphrEowsoVnosYSn7yzN4l1zQ65qjZx7Bffeab/3DSmxvQwRf3nriTqJSEa58gMT
        Er3UXZeNyA+m0fKWtcvyDYUlJJorPXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-AHselDweMWezGDFa3zdUDw-1; Mon, 04 Oct 2021 21:53:11 -0400
X-MC-Unique: AHselDweMWezGDFa3zdUDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 238BF18D6A25;
        Tue,  5 Oct 2021 01:53:10 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.11.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFB9C5D9D5;
        Tue,  5 Oct 2021 01:53:09 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 343C23C0205; Mon,  4 Oct 2021 22:53:08 -0300 (-03)
Date:   Mon, 4 Oct 2021 22:53:08 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Chunyu Hu <chuhu@redhat.com>
Subject: [RFC RT v5.10] [rt] repair usage of raw_v6_hashinfo.lock in
 raw_seq_start()
Message-ID: <YVuwBEWw4F7NGUd2@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Avoid a possible circular locking dependency by taking the softirq_ctrl.lock
before taking raw_v6_hashinfo.lock in raw_seq_start(), keeping locking order
consistent.

Lockdep splat:

[  254.623863] ======================================================
[  254.623864] WARNING: possible circular locking dependency detected
[  254.623865] 5.10.65-rt53+ #1 Tainted: G S      W I      
[  254.623866] ------------------------------------------------------
[  254.623866] read_all/3963 is trying to acquire lock:
[  254.623867] ffffa05cde218220 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip+0x116/0x2f0
[  254.623876] 
               but task is already holding lock:
[  254.623877] ffffffffb68e93e0 (raw_v6_hashinfo.lock){++.+}-{0:0}, at: raw_seq_start+0x25/0x60
[  254.623883] 
               which lock already depends on the new lock.
...
[  254.623974]  Possible unsafe locking scenario:

[  254.623975]        CPU0                    CPU1
[  254.623975]        ----                    ----
[  254.623975]   lock(raw_v6_hashinfo.lock);
[  254.623976]                                lock((softirq_ctrl.lock).lock);
[  254.623977]                                lock(raw_v6_hashinfo.lock);
[  254.623978]   lock((softirq_ctrl.lock).lock);
[  254.623978] 
                *** DEADLOCK ***

[  254.623979] 3 locks held by read_all/3963:
[  254.623980]  #0: ffffa055d0c35990 (&p->lock){+.+.}-{0:0}, at: seq_read_iter+0x56/0x420
[  254.623983]  #1: ffffffffb68e93e0 (raw_v6_hashinfo.lock){++.+}-{0:0}, at: raw_seq_start+0x25/0x60
[  254.623986]  #2: ffffffffb64c8fa0 (rcu_read_lock){....}-{1:2}, at: rt_read_lock+0x7d/0x1e0


Reported-by: Chunyu Hu <chuhu@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 net/ipv4/raw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index a0188eb2689f..584d08679e3a 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -1051,7 +1051,7 @@ void *raw_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct raw_hashinfo *h = PDE_DATA(file_inode(seq->file));
 
-	read_lock(&h->lock);
+	read_lock_bh(&h->lock);
 	return *pos ? raw_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 EXPORT_SYMBOL_GPL(raw_seq_start);
@@ -1073,7 +1073,7 @@ void raw_seq_stop(struct seq_file *seq, void *v)
 {
 	struct raw_hashinfo *h = PDE_DATA(file_inode(seq->file));
 
-	read_unlock(&h->lock);
+	read_unlock_bh(&h->lock);
 }
 EXPORT_SYMBOL_GPL(raw_seq_stop);
 

