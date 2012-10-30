From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.4-rt10
Date: Tue, 30 Oct 2012 11:05:11 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1210301103350.2756@ionos>
References: <alpine.LFD.2.02.1210290957290.2756@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1210290957290.2756@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 29 Oct 2012, Thomas Gleixner wrote:

> Dear RT Folks,
> 
> I'm pleased to announce the 3.6.4-rt10 release. This is just an update
> to 3.6.4 with no RT related changes

FYI, please disable SLUB and switch back to SLAB. Seems I took a bit
too naive approach of making it suitable for RT.

Thanks,

	tglx
