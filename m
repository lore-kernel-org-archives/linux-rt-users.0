From: Clark Williams <williams@redhat.com>
Subject: Re: [RT] Warning from swake_up_all_locked in rt-4.4.4-rt11
Date: Sat, 2 Apr 2016 22:44:15 -0500
Message-ID: <20160402224415.182dbc25@sluggy.hsv.redhat.com>
References: <20160313225358.4eb9316a@sluggy.hsv.redhat.com>
	<alpine.DEB.2.11.1603140948560.3657@nanos>
	<20160401103318.GA29603@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/302C0Mr/O=+GO4zSCysMy3G"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Daniel Wagner <wagi@monom.org>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40719 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbcDCDoY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 2 Apr 2016 23:44:24 -0400
In-Reply-To: <20160401103318.GA29603@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/302C0Mr/O=+GO4zSCysMy3G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Apr 2016 12:33:18 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Thomas Gleixner | 2016-03-14 09:49:52 [+0100]:
>=20
> >On Sun, 13 Mar 2016, Clark Williams wrote:
> > =20
> >> I'm hitting the WARN_ON(wakes > 2) in $SUBJECT when resuming from susp=
end on my laptop (quad-core i7 with HT on). Looks like the warning gets hit=
 36 times on resume. E.g.: =20
> >If resume is the only case, then we can filter that out and not worry ab=
out it
> >at all :) =20
>=20
> This works with the "mem" and "disk" target:
>=20
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -194,6 +194,12 @@ struct platform_freeze_ops {
>  	void (*end)(void);
>  };
> =20
> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
> +extern bool pm_in_action;
> +#else
> +# define pm_in_action false
> +#endif
> +
>  #ifdef CONFIG_SUSPEND
>  /**
>   * suspend_set_ops - set platform dependent suspend operations
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index bfd9e0982f15..fbb23f93e8d6 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -648,6 +648,10 @@ static void power_down(void)
>  		cpu_relax();
>  }
> =20
> +#ifndef CONFIG_SUSPEND
> +bool pm_in_action;
> +#endif
> +
>  /**
>   * hibernate - Carry out system hibernation, including saving the image.
>   */
> @@ -660,6 +664,8 @@ int hibernate(void)
>  		return -EPERM;
>  	}
> =20
> +	pm_in_action =3D true;
> +
>  	lock_system_sleep();
>  	/* The snapshot device should not be opened while we're running */
>  	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
> @@ -725,6 +731,7 @@ int hibernate(void)
>  	atomic_inc(&snapshot_device_available);
>   Unlock:
>  	unlock_system_sleep();
> +	pm_in_action =3D false;
>  	return error;
>  }
> =20
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 80ebc0726290..393bc342c586 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -522,6 +522,8 @@ static int enter_state(suspend_state_t state)
>  	return error;
>  }
> =20
> +bool pm_in_action;
> +
>  /**
>   * pm_suspend - Externally visible function for suspending the system.
>   * @state: System sleep state to enter.
> @@ -536,6 +538,8 @@ int pm_suspend(suspend_state_t state)
>  	if (state <=3D PM_SUSPEND_ON || state >=3D PM_SUSPEND_MAX)
>  		return -EINVAL;
> =20
> +	pm_in_action =3D true;
> +
>  	error =3D enter_state(state);
>  	if (error) {
>  		suspend_stats.fail++;
> @@ -543,6 +547,7 @@ int pm_suspend(suspend_state_t state)
>  	} else {
>  		suspend_stats.success++;
>  	}
> +	pm_in_action =3D false;
>  	return error;
>  }
>  EXPORT_SYMBOL(pm_suspend);
> diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
> index 8459561f0379..205fe36868f9 100644
> --- a/kernel/sched/swait.c
> +++ b/kernel/sched/swait.c
> @@ -1,5 +1,6 @@
>  #include <linux/sched.h>
>  #include <linux/swait.h>
> +#include <linux/suspend.h>
> =20
>  void __init_swait_queue_head(struct swait_queue_head *q, const char *nam=
e,
>  			     struct lock_class_key *key)
> @@ -42,7 +43,9 @@ void swake_up_all_locked(struct swait_queue_head *q)
>  		list_del_init(&curr->task_list);
>  		wakes++;
>  	}
> -	WARN_ON(wakes > 2);
> +	if (pm_in_action)
> +		return;
> +	WARN(wakes > 2, "complate_all() with %d waiters\n", wakes);
>  }
>  EXPORT_SYMBOL(swake_up_all_locked);
> =20
> Sebastian

Applied to 4.4.6-rt12, suspended/resumed multiple times with no warnings fr=
om swake_up_all_locked().

Tested-by: Clark Williams <williams@redhat.com>

--Sig_/302C0Mr/O=+GO4zSCysMy3G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXAJGPAAoJEOI5asVwYXLrDKkQAJGNZ+hT+qFXe/0Ma5tczmV7
u9mEKdqhPJmp9juYF8/RoZmGii5w3V+vF3YyloaRv0EUodso7kro8lktL1Grec2S
uDD8DrfRbwSX/yQASXsXINfFlncrOTqNEWWqlt+y8z/QcaimandXxncFfDTCT3hC
txrqcTUI9jLHJk7dxFo9VGGqIlhHsniLRtmMMO3MGrFcMvKdg5n20+sgxAVagS1B
uv8C1d6xUPZCHXpa9Gyo/O4pPVBWIO+nuD+eMpmF64PsGM76Ca046bj/g+++cMZ+
zZS5nXXkNk22PSdxdmaVghpnLneLKhKY4PCPiSwDGH9Kj5gmkpNN/+iihOpPIf+0
UafBkAeoE0WETEIhz9LMxmmt9Qs1F2iFYUJWmHWprmR4dS27erBdH8q8PeH+oVhK
HggQq66JDbZuSgTDapPfF1F9jrHlYyhN+Mj0glaj3PbsOqbTC2OKafaRWJ7qBBAK
fMDEVRNXIqmvw79aHCJb6TL23qLG8dt67Bg1ZZrWToulhlHdR1U8U7Ll7w/VE5U/
h7UgmsD4hEG7CXh5y4rANdVURa4np+MweJhJ5Z86etEtwJUTsJ3dNbWltjp5Ngl/
FOfK+bp/QMGp6E/uy1zJMjkf3q7wKu7eMM2d4mkxUlmH0yhxP8ZUsG4QrXP0R9q4
hx28aOOiusv4RTKq5rHo
=vVqW
-----END PGP SIGNATURE-----

--Sig_/302C0Mr/O=+GO4zSCysMy3G--
