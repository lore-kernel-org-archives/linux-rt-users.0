From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 3/5] trace: correct off by one while recording the
 trace-event
Date: Tue, 12 Jul 2016 16:40:50 +0200
Message-ID: <20160712144050.GA22814@linutronix.de>
References: <20160712142153.609204728@goodmis.org>
 <20160712142214.920054617@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160712142214.920054617@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2016-07-12 10:21:56 [-0400]:

>From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
=E2=80=A6
>Cc: stable-rt@vger.kernel.org
>Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>[ Changed this to upstream version. See commit e947841c0dce ]
>Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

I am not the Author of this commit (and it is not yet in TIP). I haven'=
t
had the chance (yet) to test this and check if it breaks / works so I
did not yet respond to your patch.

Assuming this behaves equally I don't mind a diffent patch in stable vs
the devel tree (and I hope to test this & get into the devel tree
within this week).

Sebastian
