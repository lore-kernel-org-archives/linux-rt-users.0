Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1903FC4361B
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 10:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DA623B7E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 10:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgLIK1f (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 05:27:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:36469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLIK1f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 05:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607509538;
        bh=frq9sqq25DMZDjB6uA3jma1GRHkV/qJicT4PfhoqYYA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=dt8SF3ESsjhJuvvLcekeKnxNdRQMjUvzTcF79jz3V1wlxAk77HM3i5TL8yh18FQX4
         83jbnlbo3RQv4pJbgNttc4acUwK87GlPfrZWH+lgSsDnAIz+/nYHQrdM0+lffp/01i
         tdwBFmUOUE5yR57d2s60AC+e3vg7v2fw1KASV1e0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.49.92]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1jvYAW0VtG-00zBmz; Wed, 09
 Dec 2020 11:25:38 +0100
Message-ID: <facf3c932c05cfc0c8287465a94f7919bbf6ad58.camel@gmx.de>
Subject: Re: [RT] 5.9-rt14  softirq_ctrl.lock vs listening_hash[i].lock
 lockdep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Date:   Wed, 09 Dec 2020 11:25:34 +0100
In-Reply-To: <X9CheYjuXWc75Spa@hirez.programming.kicks-ass.net>
References: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
         <X9CheYjuXWc75Spa@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pGXfXPAu484lPGMOTgsOmJY3VyB1Y08Ml/FvKtuV8eJQhqVtXFL
 mKfGm9sHV5OFEooed2lO50BlFBOQURH+IuRgPDdmIIAVPp73uCQJ5DoKDw8CnhUlFnpXc1n
 oR36UQ/xAyYXowK9p8FayyEzmdjJVQfVzMtQc3n7KMPO7qvZr6l/JzMFwwdssw6x+iDxFAh
 KkZzrNXXziVeNWGp/4Fhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RF1OEvZ6Xic=:dDhMa1bwok1BLP2gGCBzV7
 Pmr5xSB2oWXt6QrmAqKhSCjXOYGuDEoIJbk9IiALJ7q5wTwImP0dw+6JqEHmC1uyMtGyAgxR0
 tPhCgjW/V4O49SNQwkIO2oI7SjU7Yc+WlTqRS4r6outOIAR5N3enzSF8tK+0QFItvOokrYNUB
 HW6ZrnBOosNWMJK9NwcJ4wNhy4aEo+om9RfoJu9AL6gb5yp0iJELWl5gOLLd7HaL0Vpjfxaz7
 mXR313AH2UI8c7enqVgz0eOKLkTsaENDTv6jrTrahoDqBb6jExsP/68NZQfm0xBf0ihO4yPZN
 JAhSWILBhhRpXXypmhiFLhm8UmwuFPJ75e71uN2K4iPGm5bH51zGnDNJse08Cp/LgyvRhOO5U
 RPV1UwnHDZr52ao0OWr0EUptomt+ntG3STWmwvkOO8zGtP0UuOyJnunp8Q3WwsD5cqFl9YDHO
 YzgEG/h6VuR6+ojNEJCMHvlXWxc7mBgKu3sUMMWVdsKtQ1atwfL95mzqDrRMnlmsx1+gfZEsb
 x72kkqf8Ye/vKZX2SgJ3HpyzOLt6JsTd5rC02w8Zn83NecWIRL8lIfYMvzVfXjkBmFpc7/i0U
 GQOo7tDg+1kU8GyAwLC/utjuc9kNkBSyZmRjM8swksiUzQEJnUHorpj0TovY7LQfe+KhFbROa
 Q77j3mXK8VFrMy3EIjOBS5GC/wzJkaToeJQDRwTNDw11oYa0F+PbU2FjC0kqrTACFVgn4h5e3
 XGGW5xronvCYZ/pkbpVPL64i6q3IbUm21Xf6Iklx2isgxMafF2eMy27z+nbIL/gqwhP98qbCS
 zMpto+uLMRbhHcWYXZl7v49b7t6XW2WvKHYnVCCIH4RnEB+AJsMAqYu/LTlELtZHAalY6zY/x
 e/bBQDaPwPyBSPLpyPKA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-12-09 at 11:05 +0100, Peter Zijlstra wrote:
>
> > [   47.844585]  Possible unsafe locking scenario:
> >
> > [   47.844586]        CPU0                    CPU1
> > [   47.844586]        ----                    ----
> > [   47.844587]   lock(&h->listening_hash[i].lock);
> > [   47.844588]                                lock((softirq_ctrl.lock)=
.lock);
> > [   47.844588]                                lock(&h->listening_hash[=
i].lock);
> > [   47.844589]   lock((softirq_ctrl.lock).lock);
> > [   47.844590]
> >                 *** DEADLOCK ***
> >
> >
> So I've been looking at these local_lock vs lockdep splats for a bit,
> and unlike the IRQ inversions as reported here:
>
>   https://lore.kernel.org/linux-usb/20201029174348.omqiwjqy64tebg5z@linu=
tronix.de/
>
> I think the above is an actual real problem (for RT).
>
> AFAICT the above translates to:
>
>   inet_listen()
>     lock_sock()
>       spin_lock_bh(&sk->sk_lock.slock);
> 	acquire(softirq_ctrl);
> 	acquire(&sk->sk_lock.slock);
>
>     inet_csk_listen_start()
>       sk->sk_prot->hash() :=3D inet_hash()
> 	local_bh_disable()
> 	__inet_hash()
> 	  spin_lock(&ilb->lock);
> 	    acquire(&ilb->lock);
>
>   ----
>
>   tcp4_seq_next()
>     listening_get_next()
>       spin_lock(&ilb->lock);
> 	acquire(&ilb->lock);
>
>   tcp4_seq_show()
>     get_tcp4_sock()
>       sock_i_ino()
> 	read_lock_bh(&sk->sk_callback_lock);
> 	  acquire(softirq_ctrl)	// <---- whoops
> 	  acquire(&sk->sk_callback_lock)
>
>
> Which you can run in two tasks on the same CPU (and thus get the same
> softirq_ctrl local_lock), and deadlock.
>
> By holding softirq_ctrl we serialize against softirq-context
> (in-softirq) but that isn't relevant here, since neither context is
> that.
>
> On !RT there isn't a problem because softirq_ctrl isn't an actual lock,
> but the moment that turns into a real lock (like on RT) you're up a
> creek.
>
> In general we have the rule that as long as a lock is only ever used
> from task context (like the above ilb->lock, afaict) then it doesn't
> matter if you also take it with (soft)irqs disabled or not. But this
> softirq scheme breaks that. If you ever take a lock with BH disabled,
> you must now always take it with BH disabled, otherwise you risk
> deadlocks against the softirq_ctrl lock.
>
> Or am I missing something obvious (again) ?

Sebastian fixed this via...

=46rom 0fe43be6c32e05d0dd692069d41a40c5453a2195 Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Mon, 12 Oct 2020 17:33:54 +0200
Subject: tcp: Remove superfluous BH-disable around listening_hash

Commit
   9652dc2eb9e40 ("tcp: relax listening_hash operations")

removed the need to disable bottom half while acquiring
listening_hash.lock. There are still two callers left which disable
bottom half before the lock is acquired.

Drop local_bh_disable() around __inet_hash() which acquires
listening_hash->lock, invoke inet_ehash_nolisten() with disabled BH.
inet_unhash() conditionally acquires listening_hash->lock.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/linux-rt-users/12d6f9879a97cd56c09fb53dee343=
cbb14f7f1f7.camel@gmx.de/
Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 net/ipv4/inet_hashtables.c  | 19 ++++++++++++-------
 net/ipv6/inet6_hashtables.c |  5 +----
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 45fb450b4522..5fb95030e7c0 100644
=2D-- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -635,7 +635,9 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 	int err =3D 0;

 	if (sk->sk_state !=3D TCP_LISTEN) {
+		local_bh_disable();
 		inet_ehash_nolisten(sk, osk, NULL);
+		local_bh_enable();
 		return 0;
 	}
 	WARN_ON(!sk_unhashed(sk));
@@ -667,11 +669,8 @@ int inet_hash(struct sock *sk)
 {
 	int err =3D 0;

-	if (sk->sk_state !=3D TCP_CLOSE) {
-		local_bh_disable();
+	if (sk->sk_state !=3D TCP_CLOSE)
 		err =3D __inet_hash(sk, NULL);
-		local_bh_enable();
-	}

 	return err;
 }
@@ -682,17 +681,20 @@ void inet_unhash(struct sock *sk)
 	struct inet_hashinfo *hashinfo =3D sk->sk_prot->h.hashinfo;
 	struct inet_listen_hashbucket *ilb =3D NULL;
 	spinlock_t *lock;
+	bool state_listen;

 	if (sk_unhashed(sk))
 		return;

 	if (sk->sk_state =3D=3D TCP_LISTEN) {
+		state_listen =3D true;
 		ilb =3D &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
-		lock =3D &ilb->lock;
+		spin_lock(&ilb->lock);
 	} else {
+		state_listen =3D false;
 		lock =3D inet_ehash_lockp(hashinfo, sk->sk_hash);
+		spin_lock_bh(lock);
 	}
-	spin_lock_bh(lock);
 	if (sk_unhashed(sk))
 		goto unlock;

@@ -705,7 +707,10 @@ void inet_unhash(struct sock *sk)
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
index 55c290d55605..9bad345cba9a 100644
=2D-- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -333,11 +333,8 @@ int inet6_hash(struct sock *sk)
 {
 	int err =3D 0;

-	if (sk->sk_state !=3D TCP_CLOSE) {
-		local_bh_disable();
+	if (sk->sk_state !=3D TCP_CLOSE)
 		err =3D __inet_hash(sk, NULL);
-		local_bh_enable();
-	}

 	return err;
 }
=2D-
2.29.2


