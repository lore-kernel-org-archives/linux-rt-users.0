From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 6/6] [ARM] Use atomic_spin_lock/atomic_spin_unlock for
	irqdesc lock
Date: Fri, 7 Aug 2009 22:54:11 +0200
Message-ID: <20090807205411.GA2422@pengutronix.de>
References: <20090807203939.GA19374@pengutronix.de> <1249677761-19470-6-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755189AbZHGUyM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249677761-19470-6-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

> diff --git a/mm/highmem.c b/mm/highmem.c
> index 66e915a..214eefd 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -372,8 +372,8 @@ void *kmap_high_get(struct page *page)
>  	lock_kmap_any(flags);
>  	vaddr =3D (unsigned long)page_address(page);
>  	if (vaddr) {
> -		BUG_ON(pkmap_count[PKMAP_NR(vaddr)] < 1);
> -		pkmap_count[PKMAP_NR(vaddr)]++;
> +		BUG_ON(atomic_read(&pkmap_count[PKMAP_NR(vaddr)]) < 1);
> +		atomic_add(1, pkmap_count[PKMAP_NR(vaddr)]);
>  	}
>  	unlock_kmap_any(flags);
>  	return (void*) vaddr;
ups, this hunk doesn't belong here.  I will follow up with a corrected
patch.

Sorry
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
