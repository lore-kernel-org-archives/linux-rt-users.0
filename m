From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH 1/2] raid5: Use raw_spinlock for stripe management.
Date: Tue, 25 Apr 2017 16:09:29 -0500
Message-ID: <20170425210929.GN25232@jcartwri.amer.corp.natinst.com>
References: <1493040816-24038-1-git-send-email-gq@cs.msu.su>
 <20170425154646.GK25232@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Cc: <linux-rt-users@vger.kernel.org>,
        Alexander GQ Gerasiov <gq@redlab-i.ru>
To: Alexander GQ Gerasiov <gq@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:55343 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031744AbdDYVJm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Apr 2017 17:09:42 -0400
Content-Disposition: inline
In-Reply-To: <20170425154646.GK25232@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2017 at 10:46:46AM -0500, Julia Cartwright wrote:
> On Mon, Apr 24, 2017 at 04:33:35PM +0300, Alexander GQ Gerasiov wrote:
> > From: Alexander GQ Gerasiov <gq@redlab-i.ru>
>=20
> Hello Alexander-
>=20
> > This commit fixes the following warning:
>=20
> In general, with the class of "convert to raw spinlock" patches, it's
> nice to have written affirmation in the commit message that you've
> looked through all of the codepaths and ensured bounded, minimal
> behavior.
>=20
> > [ ] BUG: sleeping function called from invalid context at kernel/lockin=
g/rtmutex.c:993
> > [ ] in_atomic(): 0, irqs_disabled(): 1, pid: 58, name: kworker/u12:1
> > [ ] CPU: 5 PID: 58 Comm: kworker/u12:1 Tainted: G        W       4.9.20=
-rt16-stand6-686 #1
> > [ ] Hardware name: Supermicro SYS-5027R-WRF/X9SRW-F, BIOS 3.2a 10/28/20=
15
> > [ ] Workqueue: writeback wb_workfn (flush-253:0)
> > [ ]  edf21a34 c12cdc6f c1078f0a edf08c40 edf21a64 c10787c1 c1668778 000=
00000
> > [ ]  00000001 0000003a edf09144 00000000 80000000 ec694b18 ec775748 ec6=
94ad0
> > [ ]  edf21a70 c1584587 ec775790 edf21ac4 f893e8a3 00000000 c1078e52 000=
00000
> > [ ] Call Trace:
> > [ ]  [<c12cdc6f>] dump_stack+0x47/0x68
> > [ ]  [<c1078f0a>] ? migrate_enable+0x4a/0xf0
> > [ ]  [<c10787c1>] ___might_sleep+0x101/0x180
> > [ ]  [<c1584587>] rt_spin_lock+0x17/0x40
> > [ ]  [<f893e8a3>] add_stripe_bio+0x4e3/0x6c0 [raid456]
> > [ ]  [<c1078e52>] ? preempt_count_add+0x42/0xb0
> > [ ]  [<f89408f7>] raid5_make_request+0x737/0xdd0 [raid456]
>=20
> Did you cut off the bottom of the callstack, here?

Looking at this some more, I imagine the callpath which is problematic
is:

   <writeback kworker>
   ...
   add_stripe_bio()
     stripe_add_to_batch_list()
       lock_two_stripes()
         local_irq_disable()
         spin_lock(&sh{1,2}->stripe_lock) --> ___might_sleep() --> BOOM

That is, it's the local_irq_disable() in lock_two_stripes() which is the
problem.  That's my gut feel, anyway. Can you give this patch a try and
see if works?  You'll probably still want the second patch in your
series.

   Julia

-- 8< --
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index fa2c4de32a64..54dc2995aeee 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -110,8 +110,7 @@ static inline void unlock_device_hash_lock(struct r5con=
f *conf, int hash)
 static inline void lock_all_device_hash_locks_irq(struct r5conf *conf)
 {
 	int i;
-	local_irq_disable();
-	spin_lock(conf->hash_locks);
+	spin_lock_irq(conf->hash_locks);
 	for (i =3D 1; i < NR_STRIPE_HASH_LOCKS; i++)
 		spin_lock_nest_lock(conf->hash_locks + i, conf->hash_locks);
 	spin_lock(&conf->device_lock);
@@ -121,9 +120,9 @@ static inline void unlock_all_device_hash_locks_irq(str=
uct r5conf *conf)
 {
 	int i;
 	spin_unlock(&conf->device_lock);
-	for (i =3D NR_STRIPE_HASH_LOCKS; i; i--)
-		spin_unlock(conf->hash_locks + i - 1);
-	local_irq_enable();
+	for (i =3D NR_STRIPE_HASH_LOCKS - 1; i; i--)
+		spin_unlock(conf->hash_locks + i);
+	spin_unlock_irq(conf->hash_locks);
 }
=20
 /* bio's attached to a stripe+device for I/O are linked together in bi_sec=
tor
@@ -732,12 +731,11 @@ static bool is_full_stripe_write(struct stripe_head *=
sh)
=20
 static void lock_two_stripes(struct stripe_head *sh1, struct stripe_head *=
sh2)
 {
-	local_irq_disable();
 	if (sh1 > sh2) {
-		spin_lock(&sh2->stripe_lock);
+		spin_lock_irq(&sh2->stripe_lock);
 		spin_lock_nested(&sh1->stripe_lock, 1);
 	} else {
-		spin_lock(&sh1->stripe_lock);
+		spin_lock_irq(&sh1->stripe_lock);
 		spin_lock_nested(&sh2->stripe_lock, 1);
 	}
 }
@@ -745,8 +743,7 @@ static void lock_two_stripes(struct stripe_head *sh1, s=
truct stripe_head *sh2)
 static void unlock_two_stripes(struct stripe_head *sh1, struct stripe_head=
 *sh2)
 {
 	spin_unlock(&sh1->stripe_lock);
-	spin_unlock(&sh2->stripe_lock);
-	local_irq_enable();
+	spin_unlock_irq(&sh2->stripe_lock);
 }
=20
 /* Only freshly new full stripe normal write stripe can be added to a batc=
h list */

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAlj/uwYACgkQjNrC4UVN
dG9m9Qf9Hq2nB+nkauqlHTtuvmcep36DCgpeakV25lRBzOGetHQzrzT+JgMCBaSJ
bBb6o/AtRbYFIKC7pG1DG+yPi0WVQE364LwUWXGabYt9GhhltmtPpCk0TbCLOt9M
FX1iBpLRUTMNXvohv/Y5MyXCYvvTDEYtQ8GIE8sy24CDvPKw9dt1mSmDsauDstDX
JPD48q/gI64iATd4oxHNOoOyZLSYDOszLfxqZLskMNYVjR6krOmksniN/fBccyeI
t4lCsAOXGuSQmpGLIeQlfFkufE0eMVVhN6xIdpH+B2/AFdctcEt4bJQ9Xvl7RRJU
GpJIkSUlNe5HaaBeMCVVa6Grw7spUA==
=LznR
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
