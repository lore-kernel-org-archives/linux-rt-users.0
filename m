From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.3-rt7
Date: Sat, 27 Oct 2012 10:47:58 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210271045470.2756@ionos>
References: <alpine.LFD.2.02.1210262036270.2756@ionos> <alpine.LFD.2.02.1210270006130.2756@ionos> <CAJL_dMvBKu_6-4HXL3YR-UeJ6CeHJadL26fvhO8wjw6OdA9wxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>
To: Anca Emanuel <anca.emanuel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJL_dMvBKu_6-4HXL3YR-UeJ6CeHJadL26fvhO8wjw6OdA9wxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 27 Oct 2012, Anca Emanuel wrote:

> On Sat, Oct 27, 2012 at 1:08 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Looks like CONFIG_NUMA=y exposes explosions. I just noticed that none
> > of the machines which are in my basic set of test systems have that
> > enabled.
> >
> > /me goes to do some homework
> 
> Try https://github.com/torvalds/linux/commit/6b187d0260b6cd1d0904309f32659b7ed5948af8
> 
> (mm, numa: avoid setting zone_reclaim_mode unless a node is
> sufficiently distant)

This is completely irrelevant. It fixes a post 3.6 issue and has
nothing to do with the problem at hand.
