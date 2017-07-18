From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: Re: [BUG] x86/mm: Found insecure W+X mapping at address
 ffff88000005f000/0xffff88000005f000
Date: Tue, 18 Jul 2017 19:19:00 +0100
Message-ID: <20170718181859.GA13340@westernst>
References: <20170718085034.GA6388@piotrpc>
 <alpine.DEB.2.20.1707181410390.1945@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1707181410390.1945@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jul 18, 2017 at 02:11:35PM +0200, Thomas Gleixner wrote:
> On Tue, 18 Jul 2017, Piotr Gregor wrote:
> > 
> > Dmesg reports insecure W+X mapping found at address
> > ffff88000005f000/0xffff88000005f000
> > 
> > on 4.4.70 kernel patched with -rt83 patch:
> 
> Does the same problem happen with a plain 4.4.70? as well?
> 
> Thanks,
> 
> 	tglx
> 

Hi Thomas,

No. I will tell if I spot this.

cheers,
Piotr
