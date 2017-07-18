From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG] x86/mm: Found insecure W+X mapping at address
 ffff88000005f000/0xffff88000005f000
Date: Tue, 18 Jul 2017 14:11:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707181410390.1945@nanos>
References: <20170718085034.GA6388@piotrpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Piotr Gregor <piotrgregor@rsyncme.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718085034.GA6388@piotrpc>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 18 Jul 2017, Piotr Gregor wrote:
> 
> Dmesg reports insecure W+X mapping found at address
> ffff88000005f000/0xffff88000005f000
> 
> on 4.4.70 kernel patched with -rt83 patch:

Does the same problem happen with a plain 4.4.70? as well?

Thanks,

	tglx
	
