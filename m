From: Daniel Wagner <wagi@monom.org>
Subject: Implement complete_all() with swait
Date: Fri, 28 Oct 2016 09:17:04 +0200
Message-ID: <8d1cf9fc-4f09-7185-1cc6-a681262a20f2@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nicholas Mc Guire <der.herr@hofr.at>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I went through all the users of complete_all() in order to figure out if 
we can change the completion code using swait instead of wait. The 
motivation for this is to remove another source of non preemptable 
unbounded work for -rt.

The complete_all() code uses __wake_up_locked(..., 0) which wakes all 
waiters. Naturally, complete_all() would use swake_up_all() when using 
the swait API.

One of the main differences is how swake_up_all() is implemented 
compared to wake API. swake_up_all() toggles with irq enable/disable to 
introduce additional preemption points.


/*
  * Does not allow usage from IRQ disabled, since we must be able to
  * release IRQs to guarantee bounded hold time.
  */
void swake_up_all(struct swait_queue_head *q)
{
	struct swait_queue *curr;
	LIST_HEAD(tmp);

	if (!swait_active(q))
		return;

	raw_spin_lock_irq(&q->lock);
	list_splice_init(&q->task_list, &tmp);
	while (!list_empty(&tmp)) {
		curr = list_first_entry(&tmp, typeof(*curr), task_list);

		wake_up_state(curr->task, TASK_NORMAL);
		list_del_init(&curr->task_list);

		if (list_empty(&tmp))
			break;

		raw_spin_unlock_irq(&q->lock);
		raw_spin_lock_irq(&q->lock);
	}
	raw_spin_unlock_irq(&q->lock);
}

In the end that means we would weaken the garantees complete_all() 
current gives you. Currently you can use it in any context (mainline). 
After the swait switch, you can only use it in non IRQ context anymore.


So I went through the list of users and tried to identify which of them 
is going to make troubles. I found 4 users which are using 
complete_all() while IRQs are disabled. The rest looks like it just 
would work nice. I already fixed up a bunch of drivers which use 
complete_all() just to make really sure the single waiter is woken up. 
This list does only contain proper complete_all() users.

Just posting my notes so we have something to discuss next week.

cheers,
daniel


* complete_all() under spin_lock


** drivers/block/drbd/drbd_main.c:

The spinlock serializes the access to thi->t_state and complete_all()
is called while irq are disabled.

This seems to be a state machine.

_drbd_thread_stop()
   spin_lock_irqsave()
   if (thi->t_state == ...) { }
   thi->t_state = ...
   smp_mb()
   init_completion()
   thi->t_state = ...
   spin_unlock_irqrestore()
   wait_for_completion()

drbd_thread_setup()
   spin_lock_irqsave(
   if (thi->t_state == ...) { }
   thi->t_state = ...
   smp_mb()
   complete_all()
   spin_unlock_irqrestore()

992d6e91d365 ("drbd: fix thread stop deadlock")


** drivers/memstick/core/mspro_block.c:

msb->mrq_handler = h_mspro_block_default
memstick_init_req()
memstick_new_req()

jmb38x_ms_isr() # shared irq isr -> thread irq context
   spin_lock()
   jmb38x_ms_complete_cmd()
     memstick_next_req()
       host->card->next_request() # h_mspro_block_default()
         h_mspro_block_default()
	  mspro_block_complete_req()
	  spin_lock_irqsave()
	    complete_all()
	  spin_unlock_irqrestore()

r592.c:
kthread(..., "r592_io")
   memstick_next_req()
     ...

rtsx_pci_ms.c:
workqueue
   rtsx_pci_ms_handle_req()
     memstick_next_req()
       ...

rtsx_usb_ms.c:
workqueue
   rtsc_usb_ms_handle_req()
     memstick_next_req()
       ...

tifm_ms.c:
tifm_ms_req_tasklet
   spin_lock_irqsave()
   memstick_next_req()
   spin_unlock_irqrestore()


f1d82698029b ("memstick: use fully asynchronous request processing")


**  drivers/misc/tifm_7xx1.c:

tifm_7xx1_isr() # shared_irq -> thread context
   spin_lock()
   complete_all()
   spin_unlock()

3540af8ffddc ("tifm: replace per-adapter kthread with freezeable workqueue")


** drivers/mmc/core/core.c:

request_threaded_irq(sdhci_irq)

sdhci_irq()
   spin_lock()
   sdhci_cmd_irq()
     sdhci_finish_command()
       mmc_command_done()
         mmc_complete_cmd()
           complete_all()
   spin_unlock()

5163af5a5e2e ("mmc: core: Add support for sending commands during data 
transfer")


** fs/autofs4/expire.c:

autofs4_root_ioctl_unlock()
   autofs4_expire_run()
     complete_all()

autofs4_root_ioctl_unlock()
   autofs4_expire_mutli()
     autofs4_do_expire_multi()
       spin_lock()
       complete_all()
       spin_unlock()

6e60a9ab5f5d ("autofs4: fix direct mount pending expire race")


* misc


** drivers/block/amiflop.c:

timer
   motor_on_callback()
     complete_all()

6d0be946e150 ("m68k: amiflop - Get rid of sleep_on calls")


** drivers/block/cciss.c:

remove_from_scan_list()
   mutex_lock()
   complete_all()
   mutex_unlock()

b368c9dd6598 ("cciss: Use one scan thread per controller and fix hang 
during rmmod")


** drivers/block/rbd.c:

net/ceph/osd_client.c:
mutex_lock()
   complete_request()
     __complete_request() -> rbd_od_req_callback
mutext_unlock()


rbd_osd_req_callback()
   rbd_obj_request_complete()
     complete_all()

788e2df3b92e ("rbd: implement sync object read with new code")


** drivers/gpu/drm/drm_atomic_helper.c:

documantion indicates all happen under wwmutex

https://lwn.net/Articles/653466/

drm_atomic_helper_update_plane()
   drm_atomic_commit()
     ->atomic_commit()

imx-drm-core.c
imx_drm_atomic_commit() # ->atomic_commit
   drm_atomic_helper_commit()
     drm_atomic_helper_setup_commit()
       complete_all()


a095caa7f5ec ("drm/atomic-helper: roll out commit synchronization")


** drivers/gpu/drm/drm_fops.c:

see above

3b24f7d67581 ("drm/atomic: Add struct drm_crtc_commit to track async 
updates")


** drivers/infiniband/core/umem_odp.c:

ib_umem_notifier_invalidate_page
   down_read()
   invalidate_page_trampoline()
     ib_umem_notifier_end_account()
       complete_all()
    up_read()


ib_umem_odp_map_dma_pages()
   down_read()
   ib_umem_odp_map_dma_single_page()
      invalidate_page_trampoline()
        ib_umem_notifier_end_account()
          complete_all()
   up_read()

882214e2b128 ("IB/core: Implement support for MMU notifiers regarding on 
demand paging regions")


** drivers/misc/mic/scif/scif_nodeqp.c:

scif_get_node_info_resp()
   mutex_lock()
   complete_all()
   mutex_unlock()

fdd9fd5c38af ("misc: mic: SCIF messaging and node enumeration APIs")


** drivers/misc/ti-st/st_kim.c:

kim_int_recv()
   validate_firmware_response()
     complete_all()

workqueue
mgsl_bh_handler()
   get_rx_frame()
     msgl_get_raw_rx_frame()
       ldisc_receive_buf()
         ops->receive_buf()

st_ldisc_ops->receive_buf = st_tty_receivce

st_tty_receive()
   st_kim_recv()
     kim_int_recv()
       kim_check_data_len()
         validate_firmware_response()
           complete_all()

d0088ce183ad ("Staging: sources for Init manager module")


** drivers/rapidio/rio_cm.c:

riocm_cdev_ioctl()
   riocm_cdev_close()
     riocm_ch_close()
       complete_all()

fiocm_cdev_fops->release = riocm_cdev_release

riocm_cdev_release()
   riocm_ch_close()
     complete_all


b6e8d4aa1110 ("rapidio: add RapidIO channelized messaging driver")


** fs/btrfs/qgroup.c:

btrfs_qgroup_rescan_worker()
   mutex_lock()
   mutex_unlock()
   complete_all()

57254b6ebce4 ("Btrfs: add ioctl to wait for qgroup rescan completion")


** fs/ceph/file.c:

net/ceph_osd_client.c:handle_reply()
   mutex_lock()
   mutex_unlock()
   req->r_unsafe_callback()  # ceph_sync_write_unsafe

ceph_sync_write()
   req->r_unsafe_callback = ceph_sync_write_unsafe

ceph_sync_write_unsafe()
   complete_all()

fe5da05e9798 ("libceph: redo callbacks and factor out MOSDOpReply decoding")


** fs/ceph/mds_client.c:

cleanup_session_request()
   mutex_lock()
   __unregister_request()
     complete_all()
   mutex_unlock()

fc55d2c9448b ("ceph: wake up 'safe' waiters when unregistering request")


** fs/gfs2/ops_fstype.c:

gfs2_mount()
   mutex_lock()
   mutex_unlock()
   fill_super()
     init_inodes()
       complete_all()

0e48e055a7df ("GFS2: Prevent recovery before the local journal is set")


** net/ceph/mon_client.c:

handle_statfs_reply()
   mutex_lock()
   mutex_unlock()
   complete_generic_request()
     complete_all()

d0b19705e999 ("libceph: async MON client generic requests")


** net/ceph/osd_client.c:

map_check_cb()
   check_pool_dne()
     down_write()
     complete_request()
       __complete_request()
         complete_all()
     up_write()

ceph_osdc_handle_map()
   down_write()
   handle_one_map()
     scan_request()
       check_pool_dne()
         __complete_request()
           complete_all()
   up_write()

handle_reply()
   __complete_request
     complete_all()

handle_reply()
   mutex_lock()
   mutex_unlock()
   complete_all()

linger_commit_cb()
   mutex_lock()
   linger_reg_commit_complete()
     complete_all
   mutex_unlock()

handle_watch_notify()
   mutex_lock()
   complete_all()
   mutex_unlock()

wait_request_timeout()
   wait_for_completion_killable_timeout()
   complete_alll()

4609245e2670 ("libceph: pool deletion detection")


** sound/pci/hda/hda_intel.c:

snd_device_free()
   __snd_device_free()
     dev->ops->dev_free() # azx_dev_free()

avz_create()
   static struct snd_device_ops ops = {
     .dev_disconnect = azx_dev_disconnect,
     .dev_free = azx_dev_free,
   }

avx_dev_free()
   axz_free()
     complete_all()

9a34af4a3327 ("ALSA: hda - Move more PCI-controller-specific stuff from 
generic code")


* pm


** drivers/base/power/main.c:

kernel/kexec_core.c:kernel_kexec()
   mutex_trylock()
   dpm_resume_start()
   dpm_resume_end()
   mutex_lock()

drivers/xen/xenbus.c:xenwatch_thread()
   drivers/xen/manage.c:shutwdown_watch.callback=shutdown_handler
     shutdown_handler()
       do_suspend()
         dpm_resume_start()

arch/x86/kernel/apm_32.c:apm_mainloop()
   apm_event_handler()
     check_events()

     standby()
       dpm_resume_start()

     suspend()
       dpm_resume_start()

dpm_resume_start()
   dmp_resume_noirq()
     async_resume_noirq()
       device_resume_noirq()
         complete_all()

dmp_resume_noirq()
   device_resume_noirq()
     complete_all()


kernel/reboot.c
   syscall(reboot)
     hiberante()

kernel/power/autosleep.c:
   try_to_suspend() # running from workqueue context
     hibernate()

kernel/power/main.c:
   state_store()
     hiberante()

kernel/power/hibernate.c:
hibernate()
   hiernation_snapshot()
     create_image
       dpm_resume_start()

152e1d592071 ("PM: Prevent waiting forever on asynchronous resume after 
failing suspend")


*** calling complete_all() twice
device_register()
   device_initialize()
     device_pm_init()
       device_pm_sleep_init()
         init_completion()
         complete_all()
   device_add()
     [...]
       goto DevAttrError;
     [...]
     DevAttrError:
       device_pm_remove()
         complete_all()   # second invocation of complete_all()


** drivers/misc/mic/vop/vop_main.c:

Find out in which context the restore callback is called.

pm_generic_restore()
   pm->restore()

pm_ops()
   return pm->restore

vrtio_pci_pm_ops->restore = virtio_pci_restore

virio_pci_restore()
   virtio_device_restore()
     dev->config->reset()

vop_vq_config_ops->reset = vop_reset
vop_reset()
   complet_all()


c1becd284968 ("misc: mic: Enable VOP card side functionality")


** drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c:

pm->resume = brcmf_ops_sdio_resume

brcmf_ops_sdio_resume()
   brcmd_sdiod_freezer_off()
     complete_all()

9982464379e8 ("brcmfmac: make sdio suspend wait for threads to freeze")


* crypto


crypto: larval has multiple waiters

module_init()
   crypt_register_alg()
     crypto_wait_for_test()
       crypto_alg_tested()
         complete_all()

kthread(..., "cryptomgr_test")
   cryptomgr_test()
     crypto_alt_test()
       complete_all()


kthread(..., "cryptomgr_probe")
   cryptomgr_probe()
     complete_all()


** crypto/algapi.c:

fe3c5206adc5 ("[CRYPTO] api: Wake up all waiters when larval completes")


** crypto/algboss.c:

939e17799619 ("crypto: algboss - Hold ref count on larval")


** crypto/api.c:

fe3c5206adc5 ("[CRYPTO] api: Wake up all waiters when larval completes")


* firmware loading


** drivers/input/touchscreen/goodix.c:

request_firmware_nowait(goodix_config_cb)

goodix_config_cb()
     complete_all()

68caf85881cd ("Input: goodix - write configuration data to device")


** drivers/remoteproc/remoteproc_core.c:

request_firmware_nowait(rproc_fw_config_virtio)

rproc_fw_config_virtio()
   complete_all()

400e64df6b23 ("remoteproc: add framework for controlling remote processors")


** drivers/net/wireless/ath/ath9k/hif_usb.c:

request_firmware_nowait(ath9k_hif_usb_firmware_cb)

ath9k_hif_usb_firmware_cb()
   ath9k_hif_usb_firmware_fail()
     complete_all()

9494849e53e7 ("ath9k_htc: fix data race between 
request_firmware_nowait() callback and suspend()")


** drivers/net/wireless/ti/wlcore/main.c:

wl12xx_probe()
   wlcore_alloc_hw() # will eventually allocated memroy via 
kmalloc(GFP_KERNEL)
   wlcore_probe()
     ret = request_firmware_nowait(wlcore_nvs_cb)
     if (ret < 0)
        complete_all()

wlcore_nvs_cb()
   complete_all()

6f8d6b20bb0b ("wlcore: Load the NVS file asynchronously")


* TODO WTF category


** drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:

Seriously?

vchiq_arm_init_state()
   init_completion(&arm_state->resume_blocker);
   /* Initialise to 'done' state.  We only want to block on this
    * completion while resume is blocked */
   complete_all(&arm_state->resume_blocker);

   init_completion(&arm_state->blocked_blocker);
   /* Initialise to 'done' state.  We only want to block on this
    * completion while things are waiting on the resume blocker */
   complete_all(&arm_state->blocked_blocker);

set_suspend_state()
	switch (new_state) {
	case VC_SUSPEND_FORCE_CANCELED:
		complete_all(&arm_state->vc_suspend_complete);
		break;
	case VC_SUSPEND_REJECTED:
		complete_all(&arm_state->vc_suspend_complete);
		break;
	case VC_SUSPEND_FAILED:
		complete_all(&arm_state->vc_suspend_complete);
		arm_state->vc_resume_state = VC_RESUME_RESUMED;
		complete_all(&arm_state->vc_resume_complete);
		break;
	case VC_SUSPEND_IDLE:
		reinit_completion(&arm_state->vc_suspend_complete);
		break;
	case VC_SUSPEND_REQUESTED:
		break;
	case VC_SUSPEND_IN_PROGRESS:
		set_resume_state(arm_state, VC_RESUME_IDLE);
		break;
	case VC_SUSPEND_SUSPENDED:
		complete_all(&arm_state->vc_suspend_complete);
		break;
	default:
		BUG();
		break;
	}

71bad7f08641 ("staging: add bcm2708 vchiq driver")


** drivers/target/target_core_transport.c:

Many more call sites to transport_cmd_check_stop_to_fabric(). I got
sad when tracing them down.

target_complet_tmr_failure(struct work_struct)
    transport_cmd_check_stop_to_fabric()

transport_cmd_check_stop_to_fabric()
   transport_cmd_check_stop()
     complete_all()

a95d6511303b ("target: Use complete_all for se_cmd->t_transport_stop_comp")


* single waiter: patches pending


** drivers/base/firmware_class.c:

[PATCH v6 0/6] firmware: encapsulate firmware loading status
http://marc.info/?l=linux-kernel&m=147695715614730&w=3

https://patchwork.kernel.org/patch/9386483/
https://patchwork.kernel.org/patch/9386485/
https://patchwork.kernel.org/patch/9386481/
https://patchwork.kernel.org/patch/9386471/
https://patchwork.kernel.org/patch/9386475/
https://patchwork.kernel.org/patch/9386473/


** drivers/video/fbdev/omap2/omapfb/dss/apply.c

https://patchwork.kernel.org/patch/9347931/


** drivers/usb/gadget/function/f_fs.c.

https://patchwork.kernel.org/patch/9345325/


** drivers/mfd/mc13xxx-core.c

https://patchwork.kernel.org/patch/9345315/
