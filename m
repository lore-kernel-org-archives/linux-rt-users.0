From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 Resend 3/4] workqueue: Schedule work on non-idle cpu
	instead of current one
Date: Fri, 4 Jan 2013 16:41:47 +0530
Message-ID: <CAKohpokBMhto6xzp3MPGRJqstEkkC=kzgrKNhVXzi1Y8GejkXg@mail.gmail.com>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
	<ad25c731a6ca1bd1269555245952f05c856a9759.1352196505.git.viresh.kumar@linaro.org>
	<20121126171539.GZ15971@htj.dyndns.org>
	<CAKohpom9=K976NmyFWtXx2UQyRcLAqsoGw-5AaqXRpSL6uxP_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: venki-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org,
	paul.mckenney-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org,
	pdsw-power-team-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, pjt-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAKohpom9=K976NmyFWtXx2UQyRcLAqsoGw-5AaqXRpSL6uxP_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tejun,

On 27 November 2012 10:49, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 26 November 2012 22:45, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Tue, Nov 06, 2012 at 04:08:45PM +0530, Viresh Kumar wrote:
>
>> I'm pretty skeptical about this.  queue_work() w/o explicit CPU
>> assignment has always guaranteed that the work item will be executed
>> on the same CPU.  I don't think there are too many users depending on
>> that but am not sure at all that there are none.  I asked you last
>> time that you would at the very least need to audit most users but it
>> doesn't seem like there has been any effort there.
>
> My bad. I completely missed/forgot that comment from your earlier mails.
> Will do it.

And this is the first thing i did this year :)

So there are almost 1200 files which are using: queue_work, queue_delayed_work,
schedule_work, schedule_delayed_work or schedule_on_each_cpu

Obviously i can't try to understand all of them :) , and so i tried to
search two
strings in them: "cpu" or "processor_id". So, this would catch every
file of these 1200
odd files which use some variables/comment/code with cpu or smp_processor_id or
raw_processor_id, etc..

I got around 650 files with these two searches.. Then i went into
these files to see if
there is anything noticeable, which may break due to this patch...

I got a list of files where cpu/processor_id strings are found, which
may break with
this patch (still can't guarantee as i don't have knowledge of these drivers)...

- arch/powerpc/mm/numa.c
- arch/s390/appldata/appldata_base.c
- arch/s390/kernel/time.c
- arch/s390/kernel/topology.c
- arch/s390/oprofile/hwsampler.c
- arch/x86/kernel/cpu/mcheck/mce.c
- arch/x86/kernel/tsc.c
- arch/x86/kvm/x86.c
- block/blk-core.c
- block/blk-throttle.c
- block/blk-genhd.c
- crypto/cryptd.c
- drivers/base/power/domain.c
- drivers/cpufreq/cpufreq.c
- drivers/hv/vmbus_drv.c
- drivers/infiniband/hw/qib/qib_iba7322.c and
drivers/infiniband/hw/qib/qib_init.c
- drivers/md/dm-crypt.c
- drivers/md/md.c
- drivers/net/ethernet/sfc/efx.c
- drivers/net/ethernet/tile/tilepro.c
- drivers/net/team/team_mode_loadbalance.c
- drivers/oprofile/cpu_buffer.c
- drivers/s390/kvm/kvm_virtio.c
- drivers/scsi/fcoe/fcoe.c
- drivers/tty/sysrq.c
- drivers/xen/pcpu.c
- fs/file.c, file_table.c, fs/fscache/object.c
- include/linux/stop_machine.h, kernel/stop_machine.c
- mm/percpu.c
- mm/slab.c
- mm/vmstat.c
- net/core/flow.c
- net/iucv/iucv.c

I am not sure what to do now :) , can you assist ?
