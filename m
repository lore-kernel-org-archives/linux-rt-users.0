From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 3/5] trace: correct off by one while recording the
 trace-event
Date: Tue, 12 Jul 2016 10:45:55 -0400
Message-ID: <20160712104555.317c1781@gandalf.local.home>
References: <20160712142153.609204728@goodmis.org>
	<20160712142214.920054617@goodmis.org>
	<20160712144050.GA22814@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160712144050.GA22814@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 12 Jul 2016 16:40:50 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Steven Rostedt | 2016-07-12 10:21:56 [-0400]:
>=20
> >From: Sebastian Andrzej Siewior <bigeasy@linutronix.de> =20
> =E2=80=A6
> >Cc: stable-rt@vger.kernel.org
> >Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >[ Changed this to upstream version. See commit e947841c0dce ]
> >Signed-off-by: Steven Rostedt <rostedt@goodmis.org> =20
>=20
> I am not the Author of this commit (and it is not yet in TIP). I have=
n't
> had the chance (yet) to test this and check if it breaks / works so I
> did not yet respond to your patch.

That's why I added the "Changed this to upstream version".

>=20
> Assuming this behaves equally I don't mind a diffent patch in stable =
vs
> the devel tree (and I hope to test this & get into the devel tree
> within this week).

This is what's going into mainline. See commit e947841c0dce in
linux-next.

-- Steve
