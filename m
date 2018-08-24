From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: [ANNOUNCE] 4.14.63-rt40
Date: Fri, 24 Aug 2018 18:14:43 +0200
Message-ID: <7e1b2b0a-2e52-8f0d-2e17-c3ba9232f8b7@manjaro.org>
References: <20180822141458.0b6b6af7@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        =?UTF-8?Q?Philip_M=c3=bcller?= <philm@manjaro.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180822141458.0b6b6af7@gandalf.local.home>
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello everyone,

for some reason I am not able to build 4.14.63-rt40 for Manjarolinux.
Even after removing all our custom patches build fails at

  LD [M]  drivers/gpu/drm/drm.o
  AR      drivers/gpu/built-in.o
make: *** [Makefile:1035: drivers] Error 2

My config can be found here for information:
https://gitlab.manjaro.org/packages/community/realtime-kernels/linux414-rt/raw/master/config.rt

Thank you for any advice!
regards
Bernhard

On 22/08/2018 20:14, Steven Rostedt wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 4.14.63-rt40 stable release.
>
>
> This release is just an update to the new stable 4.14.63 version
> and no RT specific changes have been made.
>
> NOTE: There is a known issue with this release. The fix is here:
>
>   http://lkml.kernel.org/r/1534660115.6187.4.camel@gmx.de
>
> I did not apply it to this release because it needs to be added to
> v4.16-rt first before it gets backported. Feel free to apply it
> yourself if you have any concerns.
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   branch: v4.14-rt
>   Head SHA1: da6bee3cef4af60566dc56f3d48fce0b18165107
>
>
> Or to build 4.14.63-rt40 directly, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz
>
>   http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.63.xz
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.63-rt40.patch.xz
>
>
>
>
> Enjoy,
>
> -- Steve
>
