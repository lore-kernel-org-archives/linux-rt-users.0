From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [rt sched] SCHED_FIFO task of lower rt_priority blocks higher
 one
Date: Wed, 03 Mar 2010 22:24:18 -0600
Message-ID: <4B8F35F2.1080302@gmail.com>
References: <ac85e7a01003031921x2102d554q86c76e560f7ef6f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	linux-kernel@vger.kernel.org
To: Xianwei Zeng <linux.xianwei.zeng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ac85e7a01003031921x2102d554q86c76e560f7ef6f4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/03/2010 09:21 PM, Xianwei Zeng wrote:
> Hi,
>
> # sorry, rejected by mail list server, change the format and resend it
>
> I am using the linux-2.6.29.6-rt24 kernel on an ARM11MPCore (SMP, 4
> cores) system.
>
> In this kernel, a SCHED_FIFO task which does the following things seems
> can block other real-time processes of higher rt priority on the same CPU
> core (the test program is also attached):
>
> static void child_yielder(void)
> {
>          struct sched_param sp;
>
>          memset (&sp, 0, sizeof sp);
>          sp.sched_priority = 10;     /* Arbitrary rt priority */
>
>          if (sched_setscheduler (0, SCHED_FIFO,&sp) != 0)
>          {
>          perror("sched_setscheduler()");
>          exit (1);
>          }
>
>      while (1) {
>          sched_yield();
>      }
> }
>
> In other words, no other tasks can be scheduled, including the per-cpu's
> keventd kernel thread which has the highest rt priority(keventd is
> SCHED_FIFO, and rt_priority = 1). But real-time tasks with lower
> rt_priority can get scheduled. This sounds strange to me.
>
> I checked sched_rt.c of my kernel version(The latest kernel is almost
> the same in this part), and try to understand how a real-time task is
> enqueued, dequeued and picked up:
>
>    * enqueue a real-time task
>      - task->prio is used to find the list in rt_prio_array and add task to it;
>      - Set the bit in rt_prio_array->bitmap by task->prio;
>
>    * dequeue a real-time task
>      - Remove task from the list in rt_prio_array
>      - Clear the bit in rt_prio_array->bitmap by task->prio;
>
>    * pick up next real-time task
>      - Call sched_find_first_bit(array->bitmap) to find the list
>      - Pick the task in the list head
>
>    * yield a real-time task
>      - Instead of doing dequeue followed by enqueue, calls
>        requeue_task_rt() which moves the task from its current place to
>        the list tail.
>
> In all above operations, task->prio is used to find the bit in runqueue
> bitmap. Except for Priority Inherient, task->prio is equal to
> task->normal_prio which is calculated by function normal_prio(). For
> real-time task, its normal_prio is:
>
>     normal_prio = MAX_RT_PRIO - 1 - task->rt_priority;
>
> So the place  of a higher rt_priority real-time task is always
> __behind__ the lower rt_priority one in the runqueue bitmap. So that
> sched_find_first_bit() picks up the lower rt_priority task to run.
>
> That is why a SCHED_FIFO task can block higher rt_priority SCHED_FIFO
> tasks but lower rt_priority real-time task can be scheduled in my test.
>
> But I am confuse about:
>
>    * Does the real-time scheduler work as designed?
>    * Or arm I doing the wrong thing in my test?
>    * Why not use rt_priority to enqueue and dequeue real-time task
>      to/from runqueue list?
>
> Can somebody have a look at my questions? Thanks.

Your code has this:

			/* Child has lower rt priority than parent */
			child_yielder(PARENT_PRIO + i);

You may be confusing how the sched_setscheduler realtime priority values 
work - higher numbers are HIGHER priority, not lower (which is opposite 
to how the internal priority values work in the kernel where lower 
numbers mean higher priority, the values get converted in the kernel as 
I recall). You've spawned off a task that's higher priority than the 
current one. sched_yield in a realtime process does nothing if no 
process of the same or higher priority is available to run, so 
effectively it just spins calling sched_yield and hogging the CPU.
