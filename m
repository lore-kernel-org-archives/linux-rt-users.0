From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt9
Date: Tue, 08 Aug 2017 12:00:59 +0200
Message-ID: <1502186459.8042.31.camel@gmx.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
         <1501913583.7917.42.camel@gmx.de> <1501945043.5473.31.camel@gmx.de>
         <20170807073350.nwytftryfp34mrwi@linutronix.de>
         <1502094121.5568.22.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502094121.5568.22.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2017-08-07 at 10:22 +0200, Mike Galbraith wrote:
> On Mon, 2017-08-07 at 09:33 +0200, Sebastian Andrzej Siewior wrote:
>  
> > what timer is it :)?
> 
> kernel/exit.c:
> 851                     hrtimer_cancel(&tsk->signal->real_timer);
> 
> That one.

cb_entry being base.expired (deferred) is the "what" part.

Freshly captured crash dump:

crash> hrtimer ffff8801605a7400
struct hrtimer {
  node = {
    node = {
      __rb_parent_color = 18446612138225726464, 
      rb_right = 0xffff88017f0d4be0, 
      rb_left = 0x0
    }, 
    expires = 323599443206
  }, 
  _softexpires = 323599443206, 
  function = 0xffffffff81129f00 <it_real_fn>, 
  base = 0xffff88017f0d4580, 
  cb_entry = {
    next = 0xffff88017f0d45a0,
    prev = 0xffff88017f0d45a0
  }, 
  irqsafe = 0, 
  state = 0 '\000', 
  is_rel = 0 '\000'
}
crash> hrtimer_clock_base 0xffff88017f0d4580
struct hrtimer_clock_base {
  cpu_base = 0xffff88017f0d4440, 
  index = 0, 
  clockid = 1, 
  active = {
    head = {
      rb_node = 0xffffc900079cfa48
    }, 
    next = 0xffff88017f0d4be0
  }, 
  expired = {
    next = 0xffff88017f0d45a0, 
    prev = 0xffff88017f0d45a0
  }, 
  get_time = 0xffffffff8111dc90 <ktime_get>, 
  offset = 0
}
crash> hrtimer_clock_base -ox 0xffff88017f0d4580
struct hrtimer_clock_base {
  [ffff88017f0d4580] struct hrtimer_cpu_base *cpu_base;
  [ffff88017f0d4588] int index;
  [ffff88017f0d458c] clockid_t clockid;
  [ffff88017f0d4590] struct timerqueue_head active;
  [ffff88017f0d45a0] struct list_head expired;
  [ffff88017f0d45b0] ktime_t (*get_time)(void);
  [ffff88017f0d45b8] ktime_t offset;
}
SIZE: 0x40
crash
