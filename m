From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Re: RT is freezing
Date: Wed, 07 Jan 2015 21:39:24 -0200
Message-ID: <54ADC3AC.2090303@gmail.com>
References: <54AB147E.9060209@gmail.com>	<54AB39D2.2090203@gmail.com> <20150107112423.228e67f3@balder.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Joakim Hernberg <jhernberg@alchemy.lu>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:39683 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481AbbAGXje (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Jan 2015 18:39:34 -0500
Received: by mail-qa0-f51.google.com with SMTP id i13so5044356qae.10
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Jan 2015 15:39:33 -0800 (PST)
In-Reply-To: <20150107112423.228e67f3@balder.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Unfortunately, the patch didn't work. But now I was able to get the 
stack (see below). This stack repeats more than 1500 times during 1 second.

[  139.532236] BUG: scheduling while atomic: Xorg/1273/0x00000002
[  139.532252] Modules linked in: ctr ccm arc4 ath9k ath9k_common 
nouveau ath9k_hw bnep rfcomm ath snd_hda_codec_hdmi mac80211 
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec 
uvcvideo videobuf2_vmalloc snd_pcm videobuf2_memops videobuf2_core 
mxm_wmi videodev wmi snd_hwdep snd_seq_midi i2c_algo_bit drm_kms_helper 
snd_seq_midi_event ttm snd_rawmidi snd_seq drm intel_rapl btusb 
x86_pkg_temp_thermal snd_timer cfg80211 bluetooth snd_seq_device 
intel_powerclamp coretemp joydev parport_pc serio_raw crc32_pclmul snd 
ppdev 6lowpan_iphc lp parport mac_hid mei_me mei soundcore sony_laptop 
video lpc_ich psmouse firewire_ohci firewire_core r8169 ahci sdhci_pci 
libahci mii sdhci crc_itu_t
[  139.532253] CPU: 7 PID: 1273 Comm: Xorg Tainted: G        W 
3.14.25-rt22+ #17
[  139.532254] Hardware name: Sony Corporation VPCF215FB/VAIO, BIOS 
R0200V3 02/10/2011
[  139.532257]  00000000 00000000 e9d13c80 c1653d1b f77cbcc0 e9d13c98 
c1650b4c c182aed0
[  139.532259]  c0529300 000004f9 00000002 e9d13d14 c165708c 0000001e 
e9d13cc4 c1650e91
[  139.532262]  e9d12000 7adb3ab0 00000020 c1a84cc0 c0528f20 c0528f20 
e9d13cd8 c105abdb
[  139.532262] Call Trace:
[  139.532264]  [<c1653d1b>] dump_stack+0x48/0x76
[  139.532266]  [<c1650b4c>] __schedule_bug+0x54/0x62
[  139.532268]  [<c165708c>] __schedule+0x5dc/0x680
[  139.532270]  [<c1650e91>] ? printk+0x50/0x52
[  139.532273]  [<c105abdb>] ? print_oops_end_marker+0x3b/0x40
[  139.532275]  [<c105ac6f>] ? warn_slowpath_common+0x8f/0xa0
[  139.532278]  [<c16585be>] ? rt_mutex_slowlock+0x15e/0x1e0
[  139.532280]  [<c16585be>] ? rt_mutex_slowlock+0x15e/0x1e0
[  139.532282]  [<c165715b>] schedule+0x2b/0x90
[  139.532284]  [<c16585df>] rt_mutex_slowlock+0x17f/0x1e0
[  139.532287]  [<c1151fbd>] ? pagefault_disable+0xd/0x20
[  139.532290]  [<c1658662>] __ww_mutex_lock_interruptible+0x22/0x30
[  139.532307]  [<f8a3d33b>] nouveau_gem_ioctl_pushbuf+0x68b/0x11b0 
[nouveau]
[  139.532309]  [<c1087953>] ? migrate_enable+0x83/0x190
[  139.532326]  [<f8a3ccb0>] ? nouveau_gem_ioctl_new+0x1d0/0x1d0 [nouveau]
[  139.532334]  [<f865b73e>] drm_ioctl+0x43e/0x4d0 [drm]
[  139.532351]  [<f8a3ccb0>] ? nouveau_gem_ioctl_new+0x1d0/0x1d0 [nouveau]
[  139.532354]  [<c1087953>] ? migrate_enable+0x83/0x190
[  139.532356]  [<c1426101>] ? __pm_runtime_resume+0x41/0x50
[  139.532373]  [<f8a34ea1>] nouveau_drm_ioctl+0x41/0x70 [nouveau]
[  139.532390]  [<f8a34e60>] ? nouveau_pmops_thaw+0x60/0x60 [nouveau]
[  139.532392]  [<c1196c92>] do_vfs_ioctl+0x2e2/0x4e0
[  139.532394]  [<c10bcb48>] ? ktime_get_ts+0x48/0x140
[  139.532397]  [<c1196ef0>] SyS_ioctl+0x60/0x90
[  139.532398]  [<c16609c6>] sysenter_do_call+0x12/0x12

On 01/07/2015 08:24 AM, Joakim Hernberg wrote:
> On Mon, 05 Jan 2015 23:26:42 -0200
> Gustavo Bittencourt <gbitten@gmail.com> wrote:
>
>> It seems that the problem is with the nouveau driver. When I boot in
>> failsafe graphic mode,  the system works well. Here is my video
>> configuration:
>> $ lshw -c video
>>     *-display
>>          description: VGA compatible controller
>>          product: GF108M [GeForce GT 540M]
>>          vendor: NVIDIA Corporation
>>          physical id: 0
>>          bus info: pci@0000:01:00.0
>>          version: a1
>>          width: 64 bits
>>          clock: 33MHz
>>          capabilities: pm msi pciexpress vga_controller bus_master
>> cap_list rom
>>          configuration: driver=nouveau latency=0
>>          resources: irq:53 memory:f4000000-f4ffffff
>> memory:d0000000-dfffffff memory:e0000000-e1ffffff
>> ioport:d000(size=128) memory:f5000000-f507ffff
>>
>>
>> On 01/05/2015 08:47 PM, Gustavo Bittencourt wrote:
>>> Hi everybody
>>>
>>> I compiled the 3.14.25-rt22, but my system freezes when I start
>>> Unity and some programs like Chrome or Thunderbird. The problem
>>> happens only when PREEMPT_RT_FULL=y. No log is generated. I would
>>> like to find the root of this problem, but I don't know how. Do you
>>> have any suggestion?
> I don't know if this is related, and I'm sorry for mentioning nvidia on
> the mailinglist, but if it applies to nouveau too, I hope it's
> alright :)
>
> I have the same experience using the nvidia driver on a test system.
> This patch was brought to my attention and I use it for Archlinux'
> realtime kernel.  It appears to fix the X hangs on my nvidia test
> machine (note that for me it's just X that hangs):
>
> -NOTE: this patch is a rebase of John Blackwood's patch. On his kernel, he must be using
> -an older simple wait patch - as his applies to kernel/sched/core.c, while the simple wait
> -completion code lives in kernel/sched/completion.c ... I have ported this to test with
> -nvidia, as i would like to see if it fixes the semaphore issues i have seen.
>   
> -I've kept the original patch comment in tact;
>   
> I'm not 100% sure that the patch below will fix your problem, but we
> saw something that sounds pretty familiar to your issue involving the
> nvidia driver and the preempt-rt patch.  The nvidia driver uses the
> completion support to create their own driver's notion of an internally
> used semaphore.
>   
> Fix a race in the PRT wait for completion simple wait code.
>   
> A wait_for_completion() waiter task can be awoken by a task calling
> complete(), but fail to consume the 'done' completion resource if it
> looses a race with another task calling wait_for_completion() just as
> it is waking up.
>   
> In this case, the awoken task will call schedule_timeout() again
> without being in the simple wait queue.
>   
> So if the awoken task is unable to claim the 'done' completion resource,
> check to see if it needs to be re-inserted into the wait list before
> waiting again in schedule_timeout().
>   
> Fix-by: John Blackwood <john.blackwood@ccur.com>
>   
> --- linux-3.14/kernel/sched/completion.c    2014-05-22 14:01:03.879734869 -0400
> +++ linux-3.14/kernel/sched/completion.c    2014-05-22 14:13:59.181688658 -0400
> @@ -61,11 +61,19 @@
>   do_wait_for_common(struct completion *x,
>             long (*action)(long), long timeout, int state)
>   {
> +        int again = 0;
> +
>      if (!x->done) {
>          DEFINE_SWAITER(wait);
>    
>          swait_prepare_locked(&x->wait, &wait);
>          do {
> +                       /* Check to see if we lost race for 'done' and are
> +                        * no longer in the wait list.
> +                        */
> +                       if (unlikely(again) && list_empty(&wait.node))
> +                               swait_prepare_locked(&x->wait, &wait);
> +
>              if (signal_pending_state(state, current)) {
>                  timeout = -ERESTARTSYS;
>                  break;
> @@ -74,6 +82,7 @@
>              raw_spin_unlock_irq(&x->wait.lock);
>              timeout = action(timeout);
>              raw_spin_lock_irq(&x->wait.lock);
> +                        again = 1;
>          } while (!x->done && timeout);
>          swait_finish_locked(&x->wait, &wait);
>          if (!x->done)
>

