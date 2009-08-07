From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/6] s3c2443-ac97: convert semaphore to mutex
Date: Fri,  7 Aug 2009 22:42:37 +0200
Message-ID: <1249677761-19470-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090807203939.GA19374@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>,
	Ben Dooks <ben-linux@fluff.org>,
	Timur Tabi <timur@freescale.com>,
	Eric Miao <eric.miao@marvell.com>, alsa-devel@alsa-project.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933963AbZHGUnE@vger.kernel.org>
In-Reply-To: <20090807203939.GA19374@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This fixes a build failure for 2.6.31-rc4-rt1 (ARCH=3Darm, s3c2410_defc=
onfig):

	  CC [M]  sound/soc/s3c24xx/s3c2443-ac97.o
	sound/soc/s3c24xx/s3c2443-ac97.c:50: warning: type defaults to 'int' i=
n declaration of 'DECLARE_MUTEX'
	sound/soc/s3c24xx/s3c2443-ac97.c:50: warning: parameter names (without=
 types) in function declaration
	sound/soc/s3c24xx/s3c2443-ac97.c: In function 's3c2443_ac97_read':
	sound/soc/s3c24xx/s3c2443-ac97.c:59: error: 'ac97_mutex' undeclared (f=
irst use in this function)
	sound/soc/s3c24xx/s3c2443-ac97.c:59: error: (Each undeclared identifie=
r is reported only once
	sound/soc/s3c24xx/s3c2443-ac97.c:59: error: for each function it appea=
rs in.)
	sound/soc/s3c24xx/s3c2443-ac97.c: In function 's3c2443_ac97_write':
	sound/soc/s3c24xx/s3c2443-ac97.c:93: error: 'ac97_mutex' undeclared (f=
irst use in this function)

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Timur Tabi <timur@freescale.com>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/s3c24xx/s3c2443-ac97.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c2443-ac97.c b/sound/soc/s3c24xx/s3c24=
43-ac97.c
index 3f03d5d..bf16f20 100644
--- a/sound/soc/s3c24xx/s3c2443-ac97.c
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c
@@ -47,7 +47,7 @@ static struct s3c24xx_ac97_info s3c24xx_ac97;
=20
 static DECLARE_COMPLETION(ac97_completion);
 static u32 codec_ready;
-static DECLARE_MUTEX(ac97_mutex);
+static DEFINE_MUTEX(ac97_mutex);
=20
 static unsigned short s3c2443_ac97_read(struct snd_ac97 *ac97,
 	unsigned short reg)
@@ -56,7 +56,7 @@ static unsigned short s3c2443_ac97_read(struct snd_ac=
97 *ac97,
 	u32 ac_codec_cmd;
 	u32 stat, addr, data;
=20
-	down(&ac97_mutex);
+	mutex_lock(&ac97_mutex);
=20
 	codec_ready =3D S3C_AC97_GLBSTAT_CODECREADY;
 	ac_codec_cmd =3D readl(s3c24xx_ac97.regs + S3C_AC97_CODEC_CMD);
@@ -79,7 +79,7 @@ static unsigned short s3c2443_ac97_read(struct snd_ac=
97 *ac97,
 		printk(KERN_ERR "s3c24xx-ac97: req addr =3D %02x,"
 				" rep addr =3D %02x\n", reg, addr);
=20
-	up(&ac97_mutex);
+	mutex_unlock(&ac97_mutex);
=20
 	return (unsigned short)data;
 }
@@ -90,7 +90,7 @@ static void s3c2443_ac97_write(struct snd_ac97 *ac97,=
 unsigned short reg,
 	u32 ac_glbctrl;
 	u32 ac_codec_cmd;
=20
-	down(&ac97_mutex);
+	mutex_lock(&ac97_mutex);
=20
 	codec_ready =3D S3C_AC97_GLBSTAT_CODECREADY;
 	ac_codec_cmd =3D readl(s3c24xx_ac97.regs + S3C_AC97_CODEC_CMD);
@@ -109,7 +109,7 @@ static void s3c2443_ac97_write(struct snd_ac97 *ac9=
7, unsigned short reg,
 	ac_codec_cmd |=3D S3C_AC97_CODEC_CMD_READ;
 	writel(ac_codec_cmd, s3c24xx_ac97.regs + S3C_AC97_CODEC_CMD);
=20
-	up(&ac97_mutex);
+	mutex_unlock(&ac97_mutex);
=20
 }
=20
--=20
1.6.3.3
