From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/10] powerpc: 52xx: provide a default in mpc52xx_irqhost_map()
Date: Sun, 08 Sep 2013 08:25:49 -0400
Message-ID: <20130908122700.229691761@goodmis.org>
References: <20130908122545.421180629@goodmis.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-powerpc-52xx-provide-a-default-in-mpc52xx_irqhost_ma.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

=46rom: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

My gcc-4.3.5 fails to compile due to:

|cc1: warnings being treated as errors
|arch/powerpc/platforms/52xx/mpc52xx_pic.c: In function =E2=80=98mpc52x=
x_irqhost_map=E2=80=99:
|arch/powerpc/platforms/52xx/mpc52xx_pic.c:343: error: =E2=80=98irqchip=
=E2=80=99 may be used uninitialized in this function

since commit e34298c ("powerpc: 52xx: nop out unsupported critical
IRQs"). This warning is complete crap since only values 0=E2=80=A63 are=
 possible
which are checked but gcc fails to understand that. I wouldn't care muc=
h
but since this is compiled with -Werror I made this patch.
While add it, I replaced the warning from l2irq to l1irq since this is
the number that is evaluated.

Cc: stable-rt@vger.kernel.org # 3.8
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_pic.c
index b89ef65..b69221b 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -373,8 +373,9 @@ static int mpc52xx_irqhost_map(struct irq_domain *h=
, unsigned int virq,
 	case MPC52xx_IRQ_L1_PERP: irqchip =3D &mpc52xx_periph_irqchip; break;
 	case MPC52xx_IRQ_L1_SDMA: irqchip =3D &mpc52xx_sdma_irqchip; break;
 	case MPC52xx_IRQ_L1_CRIT:
+	default:
 		pr_warn("%s: Critical IRQ #%d is unsupported! Nopping it.\n",
-			__func__, l2irq);
+			__func__, l1irq);
 		irq_set_chip(virq, &no_irq_chip);
 		return 0;
 	}
--=20
1.7.10.4
