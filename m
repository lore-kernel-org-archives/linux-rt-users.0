From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Re: [PATCH] rtmutex: enable deadlock detection in ww_mutex_lock functions
Date: Mon, 26 Jan 2015 13:06:35 -0200
Message-ID: <54C657FB.2060106@gmail.com>
References: <20150120200229.GA17473@gbitten> <CAP=VYLq2JS0072Y0P=A+oWrt2MHjy42uG0LgQvfyHXfzf7PXeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:39332 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbbAZPGm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Jan 2015 10:06:42 -0500
Received: by mail-qa0-f41.google.com with SMTP id bm13so7063848qab.0
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Jan 2015 07:06:41 -0800 (PST)
In-Reply-To: <CAP=VYLq2JS0072Y0P=A+oWrt2MHjy42uG0LgQvfyHXfzf7PXeg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm not sure if those patches are connected, so I am posting my findings 
for anyone.

ABOUT NOUVEAU AND WW_MUTEX:
The nouveau driver intensely uses the ww_mutex. According the 
ww-mutex-design.txt documentation, the ww_mutex makes the following 
steps when try to lock a resource:

1) It calls the ww_mutex_lock (or ww_mutex_lock_interruptible) function 
for normal lock acquisition.
2) If it returns -EDEADLK,  the wounded task must drop all already 
acquired locks and call the ww_mutex_lock_slow (or 
ww_mutex_lock_slow_interruptible) function.

In the nouveau driver, those steps happen in the validate_init function 
(drivers/gpu/drm/nouveau_gem.c) when it calls the functions 
ttm_bo_reserve (step 1) and ttm_bo_reserve_slowpath (step 2):

validate_init(...)
{
...
		ret = ttm_bo_reserve(&nvbo->bo, true, false, true, &op->ticket);
		if (ret) {
			validate_fini_no_ticket(op, NULL);
			if (unlikely(ret == -EDEADLK)) {
				ret = ttm_bo_reserve_slowpath(&nvbo->bo, true,
							      &op->ticket);
...
}

THE PROBLEM:
When I run the PREEMPT_RT in my computer, it freezes as soon I start 
some big graphical application (e.g. Firefox or Chrome). The following 
execution path happens until reaching an infinite loop:

a) nouveau_gem_ioctl_pushbuf()
b) nouveau_gem_pushbuf_validate()
c) validate_init()
d) ttm_bo_reserve()
e) ttm_bo_reserve_nolru()
f) ww_mutex_lock_interruptible()
g) __ww_mutex_lock_interruptible()
h) rt_mutex_slowlock()
i) rt_mutex_handle_deadlock() -> infinite loop

The infinite loop that I mentioned above is the while(1){...} inside the 
rt_mutex_handle_deadlock function:

static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
                      struct rt_mutex_waiter *w)
{
     /*
      * If the result is not -EDEADLOCK or the caller requested
      * deadlock detection, nothing to do here.
      */
     if (res != -EDEADLOCK || detect_deadlock)
         return;

     /*
      * Yell lowdly and stop the task right here.
      */
     rt_mutex_print_deadlock(w);
     while (1) {
         set_current_state(TASK_INTERRUPTIBLE);
         schedule();
     }
}

CONCLUSION:
My conclusion was the detect_deadlock should be enabled to the 
rt_mutex_handle_deadlock function returns -EDEADLK and hence the 
ww_mutex_lock_interruptible returns -EDEADLK too. BTW, since I have 
applied my patch, I've not had anymore freezing issue.

PS: I am a kernelnewbie so it is possible that I am writing some BS here.

On 01/25/2015 06:55 PM, Paul Gortmaker wrote:
> On Tue, Jan 20, 2015 at 3:02 PM, Gustavo Bittencourt <gbitten@gmail.com> wrote:
>> The functions ww_mutex_lock_interruptible and ww_mutex_lock should return -EDEADLK when faced with
>> a deadlock. To do so, the paramenter detect_deadlock in rt_mutex_slowlock must be TRUE.
>> This patch corrects potential deadlocks when running PREEMPT_RT with nouveau driver.
>>
>> Kernel version: 3.14.25-rt22
>
> You might want to have a look at this:
>
> http://www.spinics.net/lists/linux-rt-users/msg12259.html
>
> as it also impacts what the deadlock detection flag does.
>
> Paul.
> --
>
>>
>> Signed-off-by: Gustavo Bittencourt <gbitten@gmail.com>
>> ---
>>   kernel/locking/rtmutex.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
>> index 6c40660..3f6ef91 100644
>> --- a/kernel/locking/rtmutex.c
>> +++ b/kernel/locking/rtmutex.c
>> @@ -1965,7 +1965,7 @@ __ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ww_c
>>          might_sleep();
>>
>>          mutex_acquire(&lock->base.dep_map, 0, 0, _RET_IP_);
>> -       ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 0, ww_ctx);
>> +       ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 1, ww_ctx);
>>          if (ret)
>>                  mutex_release(&lock->base.dep_map, 1, _RET_IP_);
>>          else if (!ret && ww_ctx->acquired > 1)
>> @@ -1984,7 +1984,7 @@ __ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx)
>>
>>          mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map,
>>                          _RET_IP_);
>> -       ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 0, ww_ctx);
>> +       ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 1, ww_ctx);
>>          if (ret)
>>                  mutex_release(&lock->base.dep_map, 1, _RET_IP_);
>>          else if (!ret && ww_ctx->acquired > 1)
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
