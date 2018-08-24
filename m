From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 4.14.63-rt40
Date: Fri, 24 Aug 2018 12:17:51 -0400
Message-ID: <20180824121751.606659c9@gandalf.local.home>
References: <20180822141458.0b6b6af7@gandalf.local.home>
        <7e1b2b0a-2e52-8f0d-2e17-c3ba9232f8b7@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Philip =?UTF-8?B?TcO8bGxlcg==?= <philm@manjaro.org>
To: Bernhard Landauer <oberon@manjaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7e1b2b0a-2e52-8f0d-2e17-c3ba9232f8b7@manjaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 24 Aug 2018 18:14:43 +0200
Bernhard Landauer <oberon@manjaro.org> wrote:

> Hello everyone,
> 
> for some reason I am not able to build 4.14.63-rt40 for Manjarolinux.
> Even after removing all our custom patches build fails at
> 
>   LD [M]  drivers/gpu/drm/drm.o
>   AR      drivers/gpu/built-in.o
> make: *** [Makefile:1035: drivers] Error 2
> 
> My config can be found here for information:
> https://gitlab.manjaro.org/packages/community/realtime-kernels/linux414-rt/raw/master/config.rt
> 
> Thank you for any advice!
>

Thanks for the report, I'll take a look.

-- Steve
