Return-Path: <SRS0=LljW=DT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D908C433DF
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 16:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5C12076D
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 16:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r6nJb6mV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fAr5FcJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbgJLQp5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:45:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46226 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390541AbgJLQp5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Oct 2020 12:45:57 -0400
Date:   Mon, 12 Oct 2020 18:45:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602521155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mw0frYjEmcHy+lH8fPEzgAzJHGlzJuO9p7Ascemyq/w=;
        b=r6nJb6mVGzNtSCCau9CHqK1EcFwlaoiWjGI6MoHFQV8nBsOIngm9C7rLQa/QzksrZj0Ud9
        GLYv/4eeytJQK0gCpM3mSwmuxtpjTFKnu9Kkmk1fbByJH98yPPR49HenmrHltl7yVk4yvr
        lYrOHTWUo2aKxrkPIJe4zCmT6XAelfayfNvLEmV0k6S1MRhVODVn1wNeIJs7NSHTTXfoql
        4Req1DjUan3zts+TStoGUC9p9RW2USsuL3ZPZ3CYrHVk18uwkr0wWuwUv1b/UVMdxjI1be
        0OWt3Lbghjo4IT4PH+wsD7Vmydkzqkkg0KURJseOxWPqBml5agG0ZiWHyJWmjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602521155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mw0frYjEmcHy+lH8fPEzgAzJHGlzJuO9p7Ascemyq/w=;
        b=fAr5FcJKsAqePv/01EfutuKixjyghotjPEhnnb7UEv8ifeRDe9FqypZ5iz9TAWtiZu+irM
        1MLGREPg1O0mkjCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RT] 5.9-rt14  softirq_ctrl.lock vs listening_hash[i].lock
 lockdep splat
Message-ID: <20201012164553.kkk7aaeyb3y4wvyh@linutronix.de>
References: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-10 06:31:57 [+0200], Mike Galbraith wrote:

so this then. Do you have more of these?

----------->8--------------------
Subject: [PATCH] tcp: Remove superfluous BH-disable around listening_hash

Commit
   9652dc2eb9e40 ("tcp: relax listening_hash operations")

removed the need to disable bottom half while acquiring
listening_hash.lock. There are still two callers left which disable
bottom half before the lock is acquired.

Drop local_bh_disable() around __inet_hash() which acquires
listening_hash->lock, invoke inet_ehash_nolisten() with disabled BH.
inet_unhash() conditionally acquires listening_hash->lock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/ipv4/inet_hashtables.c  | 19 ++++++++++++-------
 net/ipv6/inet6_hashtables.c |  5 +----
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 239e54474b653..fcb105cbb5465 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -585,7 +585,9 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 	int err = 0;
 
 	if (sk->sk_state != TCP_LISTEN) {
+		local_bh_disable();
 		inet_ehash_nolisten(sk, osk);
+		local_bh_enable();
 		return 0;
 	}
 	WARN_ON(!sk_unhashed(sk));
@@ -617,11 +619,8 @@ int inet_hash(struct sock *sk)
 {
 	int err = 0;
 
-	if (sk->sk_state != TCP_CLOSE) {
-		local_bh_disable();
+	if (sk->sk_state != TCP_CLOSE)
 		err = __inet_hash(sk, NULL);
-		local_bh_enable();
-	}
 
 	return err;
 }
@@ -632,17 +631,20 @@ void inet_unhash(struct sock *sk)
 	struct inet_hashinfo *hashinfo = sk->sk_prot->h.hashinfo;
 	struct inet_listen_hashbucket *ilb = NULL;
 	spinlock_t *lock;
+	bool state_listen;
 
 	if (sk_unhashed(sk))
 		return;
 
 	if (sk->sk_state == TCP_LISTEN) {
+		state_listen = true;
 		ilb = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
-		lock = &ilb->lock;
+		spin_lock(&ilb->lock);
 	} else {
+		state_listen = false;
 		lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
+		spin_lock_bh(lock);
 	}
-	spin_lock_bh(lock);
 	if (sk_unhashed(sk))
 		goto unlock;
 
@@ -655,7 +657,10 @@ void inet_unhash(struct sock *sk)
 	__sk_nulls_del_node_init_rcu(sk);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 unlock:
-	spin_unlock_bh(lock);
+	if (state_listen)
+		spin_unlock(&ilb->lock);
+	else
+		spin_unlock_bh(lock);
 }
 EXPORT_SYMBOL_GPL(inet_unhash);
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 2d3add9e61162..50fd17cbf3ec7 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -335,11 +335,8 @@ int inet6_hash(struct sock *sk)
 {
 	int err = 0;
 
-	if (sk->sk_state != TCP_CLOSE) {
-		local_bh_disable();
+	if (sk->sk_state != TCP_CLOSE)
 		err = __inet_hash(sk, NULL);
-		local_bh_enable();
-	}
 
 	return err;
 }
-- 
2.28.0

