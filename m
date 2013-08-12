From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.10.4-rt1
Date: Mon, 12 Aug 2013 10:14:30 +0200
Message-ID: <20130812081430.GA23040@linutronix.de>
References: <alpine.DEB.2.02.1308011215160.4089@ionos.tec.linutronix.de>
 <CAP=VYLp1ERhS4cFtgXGHL2DfCGoJ9VbPvShH5ZOWCpPuSzQY6w@mail.gmail.com>
 <1375419917.3743.93.camel@pasglop>
 <51FBA9CC.2090206@linutronix.de>
 <20130802141936.GA8267@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130802141936.GA8267@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Paul Gortmaker | 2013-08-02 10:19:36 [-0400]:

>The list of donor victims that aren't used in asm is getting
>smaller, but TIF_POLLING_NRFLAG seems OK and it puts RESCHED
>and RESCHED_LAZY right beside each other.

Applied & merged into the original patch. Thanks.

>Thanks guys,
>Paul.

Sebastian
