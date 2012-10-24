From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [ANNOUNCE] 3.6.3-rt6
Date: Tue, 23 Oct 2012 21:59:06 -0400
Message-ID: <CAP=VYLqF4PPuZFwm9Ft_J_neLPNYv_a-2uZ3bi_cvQoxOQrH8A@mail.gmail.com>
References: <alpine.LFD.2.02.1210232301160.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1210232301160.2756@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 23, 2012 at 5:06 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.6.3-rt6 release. rt6 is just an update
> to 3.6.3. The not announced 3.6.2-rt5 is an intermediate release with
> a single change.
>
> Changes since 3.6.2-rt4:
>
>         * Make the early printk changes work (hopefully) everywhere
>
> The new patch queue also contains a non code change (according to
> Pauls) which adds a missing subject line to a powerpc patch.

The rt5 and rt6 changes are now present in the 3.6-rt-patches repo.
Given the above, there is currently nothing for me to queue on a
separate  "-fixes" branch against rt6.  The master branch works as-is.

http://git.kernel.org/?p=linux/kernel/git/paulg/3.6-rt-patches.git;a=summary

Paul.
--

>
> The delta patch against 3.6.2-rt4 is appended below and can be found
> here:
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.2-rt4-rt5.patch.xz
>
> The RT patch against 3.6.3 can be found here:
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.3-rt6.patch.xz
>
> The split quilt queue is available at:
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patches-3.6.3-rt6.tar.xz
>
> Enjoy,
>
>         tglx
>
> ---------->
