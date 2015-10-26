From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v3 1/4] wait.[ch]: Introduce the simple waitqueue (swait)
 implementation
Date: Mon, 26 Oct 2015 20:04:26 +0800
Message-ID: <20151026120426.GA1497@fixme-laptop.cn.ibm.com>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-2-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445326090-1698-2-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

On Tue, Oct 20, 2015 at 09:28:07AM +0200, Daniel Wagner wrote:
> +
> +/*
> + * The thing about the wake_up_state() return value; I think we can ignore it.
> + *
> + * If for some reason it would return 0, that means the previously waiting
> + * task is already running, so it will observe condition true (or has already).
> + */
> +void swake_up_locked(struct swait_queue_head *q)
> +{
> +	struct swait_queue *curr;
> +
> +	list_for_each_entry(curr, &q->task_list, task_list) {
> +		wake_up_process(curr->task);
> +		list_del_init(&curr->task_list);
> +		break;

Just be curious, what's this break for? Or what's this loop(?) for?

> +	}
> +}
> +EXPORT_SYMBOL(swake_up_locked);
> +

Regards,
Boqun

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWLhbHAAoJEEl56MO1B/q4oVsIAJ1lCadePFAx/gD3JHx0DTZa
eub17aa4Wq48xCJkD7cxElsw2XppJEjSHEKx/4VcIGetuWtzBF1SyBe4PTXtbx4y
pRBT/2Ly5wAunPv2D+r2tcwr6yLnuoKy0otDAKpSRoWI6mpS7wMFqTcPBV9qFHf2
31HJrJIVl8yuLM3icIJxzUzSddJGVZvXC/lSjJ5VOxplL2IguuNUeracO1wuBhuv
QKz+gLDeHkKA4LBEFalRw7Xmxgk6PRtgkJtz/u4ZenTVllYH9RldTII79iPugLU3
jveEgdcmSYynYNFLVJiwIYwJLVDAaNarn0xWuApAj5s/7hqUUm6pFzcHCX2QDpw=
=dJ25
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
