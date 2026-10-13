Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63554518153
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Oct 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902484; cv=none; b=RviB6NpPUIokYcOXlMCKbpwk3VQn+sRGn2XaBpMairD7fr8dsif9Coklkyymcf02h76bb4nDdcKxImHzP1oK2mxRI+yS1nZEJqyo5DT51uAsB6H4AAQDPB+vmo2r2CihCexeCvEVy6j6pOmFMKG4/zeaKT/ECBJ97arbSAi6QBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902484; c=relaxed/simple;
	bh=3HzTVTKLBcHQQ/8+F+1NWpKN7SDZfiDX+voqK9CCMwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkUcxmbv4i7cmptC4i9dyS7HY8C1w3R8Zsm6KX8m3ydFq2uMjhqGf2SoZYu0WFqASsc+cp93Sax8OK1E7FKczYTh5I1LPgUdwY7/LH6wig0xVPmzEWLkS99ru1aWxa9KOSnoQ2Zu7fSmc/qumdyXPxK+cc2xllHqb199cacDH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=41FTg5V9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=is7Bnqir; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="41FTg5V9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="is7Bnqir"
Date: Tue, 13 Oct 2026 16:41:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791902480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uErNyVpCtfUPW3MFhIwE40WV48bt/HhFjAcuyMglJtw=;
	b=41FTg5V9xGAt4rJ52q+w2CL92UBCi61RXOBkI0SuXEarbJcvrhlUL7N/HcXlvUVmVMONFy
	qmUAA7cP2poD05YMrjxXay97ihKzvy/VLbypAqYLHVQ0l9H+d9/yCgo3eTUC5rQgpp582S
	t8wsiMrowFlHaa7qf/Aoluv0Ke/J11tx4wd9iVXqx/0PT8+p7PuUtn9+tFWqxNeFYciSxn
	+oPxqfBq8zaKzSpRHHuepglP7rQYEeDYhVWJSEITYvVW6G1x76PNXZUf2pGAyCYkD2BEI0
	lrMJn7iFxWHn9pfUubdOzOI1jQsofZKAPPgjeUPWghLifvqqTAWFsoi5ddj9SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791902480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uErNyVpCtfUPW3MFhIwE40WV48bt/HhFjAcuyMglJtw=;
	b=is7Bnqir7Ns93/gmLwNYxx/C7WTtWM322m1BNkIPuc20nK8IcAn/krv3DPEUZg0Jpwfxqk
	tCNuYK4SRPSzeAAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Naulls, Peter" <PeterNaulls@eaton.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Btrfs PREEMPT_RT transaction-waiter livelock: experimental
 mitigation in kernel 6.6.78
Message-ID: <20261013144119.-2EEqlL-@linutronix.de>
References: <PH0PR17MB4277167A37B20340B231443FBB922@PH0PR17MB4277.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PH0PR17MB4277167A37B20340B231443FBB922@PH0PR17MB4277.namprd17.prod.outlook.com>

On 2026-10-09 15:34:02 [+0000], Naulls, Peter wrote:
> Long term kernel hacker, but very infrequent contributor.=C2=A0
Hi Peter,

> We are using the RT kernel patch on x86 under kernel 6.6.78-rt51.
> Specifically, this is the kernel from meta-intel in Yocto Scarthgap in
> the intel-kernel-rt recipe.=C2=A0
=E2=80=A6
> sync (PID 52371)
> =C2=A0 btrfs_commit_transaction+0xc48
> =C2=A0 =C2=A0 [return address immediately after rt_spin_lock(&fs_info->tr=
ans_lock)]
> =C2=A0 btrfs_sync_fs
> =C2=A0 sync_fs_one_sb
> =C2=A0 ksys_sync

This sort of sounds like the state is TRANS_STATE_SUPER_COMMITTED but is
not making progress after that. Are there any tasks involved that run at
realtime priority and would block other tasks from making progress?

=E2=80=A6
> This is in related code. I put this patch into our 6.6.78 kernel and it d=
id not resolve the problem.=C2=A0
=E2=80=A6
> # Experimental mitigation for a suspected PREEMPT_RT Btrfs transaction-wa=
iter
> # livelock. wait_for_commit() can reselect a completed transaction that r=
emains
> # on trans_list after its waiters are woken. Skip completed entries while=
 still
> # waiting for older incomplete transactions. This is a diagnostic hypothe=
sis,
> # not a confirmed fix for the observed lockup.
> # Review notes: the scan is O(n) under trans_lock. Completion state is pu=
blished
> # locklessly elsewhere; READ_ONCE provides a single load, not acquire ord=
ering.
> # A multi-hour run did not reproduce the issue, but the lock owner and ro=
ot cause
> # remain unknown.
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index e15e1855fa0a..0f05fabe451c 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -865,6 +865,7 @@ static noinline void wait_for_commit(struct btrfs_tra=
nsaction *commit,
>                                      const enum btrfs_trans_state min_sta=
te)
>  {
>         struct btrfs_fs_info *fs_info =3D commit->fs_info;
> +       struct btrfs_transaction *next;
>         u64 transid =3D commit->transid;
>         bool put =3D false;
>=20
> @@ -893,10 +894,16 @@ static noinline void wait_for_commit(struct btrfs_t=
ransaction *commit,
>                  */
>=20
>                 spin_lock(&fs_info->trans_lock);
> -               commit =3D list_first_entry_or_null(&fs_info->trans_list,
> -                                                 struct btrfs_transactio=
n,
> -                                                 list);
> -               if (!commit || commit->transid > transid) {
> +               commit =3D NULL;
> +               list_for_each_entry(next, &fs_info->trans_list, list) {
> +                       if (next->transid > transid)
> +                               break;
> +                       if (READ_ONCE(next->state) =3D=3D TRANS_STATE_COM=
PLETED)
> +                               continue;
> +                       commit =3D next;
> +                       break;
> +               }
> +               if (!commit) {
>                         spin_unlock(&fs_info->trans_lock);
>                         break;
>                 }
>=20
>=20
> Note the O(N) time here. To that end, this is very unlikely to be the
> correct fix, but I hope it highlights the core problem. I ran this
> patch for several hours with no apparent problem (versus seconds of a
> lockup in previous testing).=20
>=20
> If there's a later kernel patch I've missed, or something else I ought
> to be looking at or test or need more info, please let me know.=20

PREEMPT_RT shouldn't do much different than !PREEMPT_RT. Do you have
tasks with different priorities? If that is the case then it might be
that one thread is blocking another thread that should make progress.
Your changes iterates over TRANS_STATE_COMPLETED so it seems that it is
not cleaned up for some reason.

Could you try if you can reproduce this with v7.3-rc7? This one does not
require any additional patches.
I'm not sure if this report would help the btrfs folks to recognize if
this is a solved problem or where the issue might be.

Sebastian
