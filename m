From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Revert "powerpc: 52xx: provide a default in mpc52xx_irqhost_map()"
Date: Tue, 01 Oct 2013 18:32:19 +0200
Message-ID: <524AF913.6020007@linutronix.de>
References: <1380612366-13504-1-git-send-email-wsa@the-dreams.de> <524A7FCB.3020406@linutronix.de> <20131001091115.GB2993@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linuxppc-dev@ozlabs.org, linux-rt-users@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39016 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab3JAQcW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Oct 2013 12:32:22 -0400
In-Reply-To: <20131001091115.GB2993@katana>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/01/2013 11:11 AM, Wolfram Sang wrote:
> Hi,

Hi Wolfram,

> Well, if you insist, I'd prefer the following patch.
>=20
> From: Wolfram Sang <wsa@the-dreams.de> Subject: [PATCH] ppc:
> mpc52xx: silence false positive from old GCC
>=20
> So people can compile with -Werror (RT patchset).

Why do you mention the RT patch set here? Doesn't the vanila tree gets
compiled with -Werror as well?

> Signed-off-by: Wolfram Sang <wsa@the-dreams.de> ---=20
> arch/powerpc/platforms/52xx/mpc52xx_pic.c |    2 +- 1 file changed,
> 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> b/arch/powerpc/platforms/52xx/mpc52xx_pic.c index b89ef65..ad3c9b0
> 100644 --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c +++
> b/arch/powerpc/platforms/52xx/mpc52xx_pic.c @@ -340,7 +340,7 @@
> static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int
> virq, { int l1irq; int l2irq; -	struct irq_chip *irqchip; +	struct
> irq_chip *irqchip =3D NULL; /* pet old compilers */

That would probably work, too. I would drop that comment but then
someone might clean that up :P

> void *hndlr; int type; u32 reg;
>=20
>> Why miss leading code? Default here does the same as unhandled
>> and crit where it does nothing.
>=20
> People not realizing 'default' is a no-op might wonder why unknown=20
> levels are mapped to critical.

I see. And what would you suggest as default in case we would have an
additional bit?

>=20
>> Any why do you want to see l2irq since it was not in the case
>> statement? l2 holds the number, l1 the level.
>=20
> We know which level it was, since the printout is only for that
> level. We probably want to know which requested IRQ was causing
> this, so we can fix the assorted driver. Otherwise we only know
> that some critical IRQ was requested somewhere.

Hmmm. I assumed that critical / SDMA / =85 are interrupt numbers but th=
ey
are seem not be. In that case I guess l2 is more important. l1 kinda
looks important since it is the value in the switch case which failed
but since it can only hold one possible value, I guess your info is
better :)

>=20
> Thanks,
>=20
> Wolfram
>=20
Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
