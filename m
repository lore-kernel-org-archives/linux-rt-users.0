From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: Question regarding RT patches for ARM
Date: Mon, 15 May 2017 15:47:06 +0200
Message-ID: <20170515134706.wughblmko3d7ouvi@linutronix.de>
References: <CAGgoGu6=EKCkzbZ0=i+4e+9rJUvxG-SUix1AQVch8VF=OmokVw@mail.gmail.com>
 <3aa42082.b247.15c0c29ca5e.Coremail.qiledexin@163.com>
 <CAGgoGu72RebHt5yf-2WE6Dt3jUNqMph2Uwu+VRK2akRYXo8aow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: GuJiangfei <qiledexin@163.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-rt-users@vger.kernel.org
To: Fawad Lateef <fawadlateef@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGgoGu72RebHt5yf-2WE6Dt3jUNqMph2Uwu+VRK2akRYXo8aow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-05-15 15:09:45 [+0200], Fawad Lateef wrote:
> Hi,
> 
> I am talking in general about RT patches. Like downloaded 4.9.20 from
> kernel.org and applied patch "4.9.20-rt16.patch".

understood

> On 15 May 2017 at 14:51, GuJiangfei <qiledexin@163.com> wrote:
> > Which rt patch do you mean?
> >
> >
> > 发自网易邮箱大师
> > On 05/15/2017 20:44, Fawad Lateef wrote:
> >
> > Hi All,
> >
> > I am working on custom i.MX6 quad hardware and using RT patches for
> > almost latest stable kernel 4.9 and facing some weird system stall OR
> > 'unhandled page fault - exceptions'.

and you are sure that this problems are caused by the RT patch or is
there a chance that this is unrelated to the RT patch?

> > Just want to confirm that "are RT patches for ARM are stable OR they
> > are still experimental?" As I heard from my other colleagues that RT
> > patches are not stable for ARM and should be avoided.

It is stable and I am not aware of any ARM / IMX specific problems.

Since this got here from kernelnewbies: I would not recommend the
Preempt-RT patch set to add to any kernel just to have fancy patches.
People use it because they need to fulfill specific requirements which
would not work without it. You might want to check some of the
documentation in the RT-wiki
	https://wiki.linuxfoundation.org/realtime/documentation/start

> > Thanks in advance,
> >
> > -- Fawad Lateef

Sebastian
