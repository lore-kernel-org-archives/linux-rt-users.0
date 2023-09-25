Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A371D691
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Sep 2023 16:31:59 +0000 (UTC)
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Sep 2023 09:31:48 PDT
Received: from smtpcmd0995.aruba.it (smtpcmd0995.aruba.it [62.149.156.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5327EDF
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Sep 2023 09:31:48 -0700 (PDT)
Received: from eurosoft.it ([10.10.10.165])
	by Aruba Outgoing Smtp  with ESMTPA
	id koTsqSaEzWtYOkoTtqkbwq; Mon, 25 Sep 2023 18:30:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1695659445; bh=iqox6k46vBnstgceyZXJCJtJIveMrN9CJwkStz0AKn0=;
	h=Date:Subject:MIME-Version:Content-Type:From:To;
	b=NshYnIEbZzEHcySJg62l6J3MiLRmUQ/bty1Qzp6hR25g8mh6sbasySsvdtpqrOfSU
	 1O2/FCCAkeT9DPQkjYSW9s+IweM53VjPNrFywb9dambW5mP17tV9wL+L7PtAQpt/AH
	 aZ+hP+rw/jaMTUUniZ6BBQrWt9CvIqzJcUwlRFL2jJZt6GltHetx9NZU8tCJ6eDbcB
	 hkYp47vg1gY22qJ3wHQ9xX8czqvEvayxVvpMI9z0EdjO1bwq6AoaK3flIhcSUAH6WP
	 K1SwHursWNU6ThxC1/sizfPkyYh/PYH20bmsBRGP0ZQyQpBtkJL5drmDdGm6rD8w1T
	 x9syGNQqAAb7g==
Date: Mon, 25 Sep 2023 18:30:44 +0200
Message-Id: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
Subject: High latency of a system based on 5.19 rt
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: multipart/mixed;
	boundary="_=__=_XaM3_.1695659445.2A.32770.42.23554.52.42.007.698192834"
Reply-To: g.medini@eurosoft.it
From: g.medini@eurosoft.it
To: linux-rt-users@vger.kernel.org
X-XaM3-API-Version: 4.2.88
X-TipoRicevuta: completa
X-type: 0
X-SenderIP: 93.57.102.244
X-CMAE-Envelope: MS4xfHcsugA5J2g7axQuuBH20KZ4HGUWEy7MTqiBQw2nzD2CC+LmyIw6vryeX/AAnCWbyLkqkOdXUagpeOHIIM+G0EOzrpTqqrtxjD+8/O2HTLHPprbfEc5T
 BdqU0aN29eDimtMdBm9dH60PyTQAkgZQflrLvHJCwLvZJWeq2QYSptV5KtiY5VsRXvLuahRV5F2lQOTBgw3BckpRkXBto/AZaXM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--_=__=_XaM3_.1695659445.2A.32770.42.23554.52.42.007.698192834
Content-Type: multipart/alternative;
	boundary="_=__=_XaM3_.1695659445.2A.32817.42.23554.52.42.007.843690610"


--_=__=_XaM3_.1695659445.2A.32817.42.23554.52.42.007.843690610
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A   Hi All, I'm struggling with a realtime issue I have.=0A=0A   Using =
trace I've found a problem related to CONFIG_X86_DEBUG_FPU that was intro=
ducing very large latency.=0A=0A   Removing this I have another one where=
 the solution is not so trivial.=0A=0A   The problem I've actually seems =
related to i915 driver.=0A=0A   With a particular load for the graphic ca=
rd (basically using ALT-TAB to switch from graphical windows or pressing =
the Win like button to resize all the graphical windows to the screen) I =
see an huge latency that gives problem to an rt task I need for my applic=
ation.=0A=0A   I've tried everything to optimize the sytem.=0A=0A   As ex=
pected I find little enhancement that help me to mitigate the problem (co=
re isolation and so on) but the basic problem remain the same (it happens=
 with X11 and Wayland also).=0A=0A   Hoping someone can help me.=0A=0A   =
Gianluca=0A=0A   Cordiali saluti=0A   Best regards=0A=0A   Avvertenze ai =
sensi del Regolamento Generale UE 679/2016 (Regolamento Privacy)=0A=0A   =
Il presente messaggio, corredato dei relativi allegati, potrebbe contener=
e informazioni strettamente riservate o confidenziali ed =C3=A8 riferito =
esclusivamente al destinatario sopra indicato. Quest=E2=80=99ultimo =C3=A8=
 l'unico autorizzato ad usarlo, copiarlo e, sotto la propria responsabili=
t=C3=A0 a diffonderlo. Chiunque ricevesse questo messaggio per errore o l=
o leggesse senza esserne legittimato =C3=A8 avvisato che trattenerlo, cop=
iarlo, divulgarlo, distribuirlo a persone diverse dal destinatario =C3=A8=
 severamente proibito ed =C3=A8 pregato di rinviarlo immediatamente al mi=
ttente distruggendo l'originale. Grazie.=0A=0A   This message, together w=
ith its annexes, may contain information strictly confidential or privile=
ged and is intended only for the addressee(s) identified above, who only =
may use, copy and, under his/their responsibility, further disseminate it=
. If you are not the intended recipient or have read it without entitleme=
nt, please be aware that keeping, copying, disseminating or distributing =
this message to persons other than the addressee(s) is strictly forbidden=
 and transmit it immediately back to the sender, deleting the original me=
ssage received. Thank you.=0A
--_=__=_XaM3_.1695659445.2A.32817.42.23554.52.42.007.843690610
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family: Arial; font-size: medium;" xam-editor-contain=
er=3D"true">Hi All, I'm struggling with a realtime issue I have.<div>Usin=
g trace I've found a problem related to CONFIG_X86_DEBUG_FPU that was int=
roducing very large latency.</div><div>Removing this I have another one w=
here the solution is not so trivial.</div><div>The problem I've actually =
seems related to i915 driver.</div><div>With a particular load for the gr=
aphic card (basically using ALT-TAB to switch from graphical windows or p=
ressing the Win like button to resize all the graphical windows to the sc=
reen) I see an huge latency that gives problem to an rt task I need for m=
y application.</div><div>I've tried everything to optimize the sytem.</di=
v><div>As expected I find little enhancement that help me to mitigate the=
 problem (core isolation and so on) but the basic problem remain the same=
 (it happens with X11 and Wayland also).</div><div><br /></div><div>Hopin=
g someone can help me.</div><div><br /></div><div>Gianluca</div><div><br =
/><br /><div data-signature-id=3D"1">=0A<div class=3D"xam_msg_class">=0A<=
span style=3D"font-family: Arial; font-size: medium;" xam-editor-containe=
r=3D"true"><div style=3D"color: rgb(34, 34, 34); font-family: Arial, Helv=
etica, sans-serif; font-size: small; background-color: rgb(255, 255, 255)=
;"><div id=3D"m_6813077285459221634AppleMailSignature" style=3D"color: rg=
b(0, 0, 0); font-family: Helvetica; font-size: 14px;"><div><table border=3D=
"0" cellpadding=3D"0" cellspacing=3D"0" width=3D"600px"><tbody><tr><td st=
yle=3D"margin: 0px;" width=3D"10"><br /></td><td colspan=3D"5" height=3D"=
10" style=3D"margin: 0px; border-top: 1px dotted rgb(174, 174, 174);"><fo=
nt size=3D"2">Cordiali saluti<br />Best regards<br /></font></td><td styl=
e=3D"margin: 0px;" width=3D"10"></td></tr></tbody><tbody><tr><td style=3D=
"margin: 0px;" width=3D"10"></td><td colspan=3D"5" style=3D"margin: 0px;"=
></td><td style=3D"margin: 0px;" width=3D"10"><br /></td></tr></tbody><tb=
ody><tr><td style=3D"margin: 0px;" width=3D"10"></td><td colspan=3D"5" he=
ight=3D"10" style=3D"margin: 0px; border-top: 1px dotted rgb(174, 174, 17=
4);"></td><td style=3D"margin: 0px;" width=3D"10"></td></tr></tbody><tbod=
y><tr><td style=3D"margin: 0px;" width=3D"10"><br /></td><td align=3D"lef=
t" colspan=3D"5" style=3D"margin: 0px; color: rgb(149, 152, 154); font-fa=
mily: Arial, Helvetica, sans-serif; font-size: 11px; line-height: 14px; p=
adding: 10px; background-color: rgb(236, 236, 236);"><p>Avvertenze ai sen=
si del Regolamento Generale UE 679/2016 (Regolamento Privacy)</p><p>Il pr=
esente messaggio, corredato dei relativi allegati, potrebbe contenere inf=
ormazioni strettamente riservate o confidenziali ed =C3=A8 riferito esclu=
sivamente al destinatario sopra indicato. Quest=E2=80=99ultimo =C3=A8 l'u=
nico autorizzato ad usarlo, copiarlo e, sotto la propria responsabilit=C3=
=A0 a diffonderlo. Chiunque ricevesse questo messaggio per errore o lo le=
ggesse senza esserne legittimato =C3=A8 avvisato che trattenerlo, copiarl=
o, divulgarlo, distribuirlo a persone diverse dal destinatario =C3=A8 sev=
eramente proibito ed =C3=A8 pregato di rinviarlo immediatamente al mitten=
te distruggendo l'originale. Grazie.</p><p>This message, together with it=
s annexes, may contain information strictly confidential or privileged an=
d is intended only for the addressee(<span class=3D"il">s</span>) identif=
ied above, who only may use, copy and, under his/their responsibility, fu=
rther disseminate it. If you are not the intended recipient or have read =
it without entitlement, please be aware that keeping, copying, disseminat=
ing or distributing this message to persons other than the addressee(<spa=
n class=3D"il">s</span>) is strictly forbidden and transmit it immediatel=
y back to the sender, deleting the original message received. Thank you.<=
/p></td></tr></tbody></table><div><br /></div></div><br /></div></div></s=
pan>=0A</div>=0A</div></div></span>
--_=__=_XaM3_.1695659445.2A.32817.42.23554.52.42.007.843690610--

--_=__=_XaM3_.1695659445.2A.32770.42.23554.52.42.007.698192834
Content-Type: text/plain; name="=?utf-8?Q?wakeup=5Frt.txt?="
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="=?utf-8?Q?wakeup=5Frt.txt?="

# tracer: wakeup_rt=0A#=0A# wakeup_rt latency trace v1.1.5 on 5.19.0-rt10=
=0A# --------------------------------------------------------------------=
=0A# latency: 357 us, #401/401, CPU#0 | (M:preempt_rt VP:0, KP:0, SP:0 HP=
:0 #P:2)=0A#    -----------------=0A#    | task: ktimers/0-15 (uid:0 nice=
:0 policy:1 rt_prio:1)=0A#    -----------------=0A#=0A#                  =
  _--------=3D> CPU#            =0A#                   / _-------=3D> irq=
s-off/BH-disabled=0A#                  | / _------=3D> need-resched    =0A=
#                  || / _-----=3D> need-resched-lazy=0A#                 =
 ||| / _----=3D> hardirq/softirq =0A#                  |||| / _---=3D> pr=
eempt-depth   =0A#                  ||||| / _--=3D> preempt-lazy-depth=0A=
#                  |||||| / _-=3D> migrate-disable =0A#                  =
||||||| /     delay           =0A#  cmd     pid     |||||||| time  |   ca=
ller     =0A#     \   /        ||||||||  \    |    /       =0Agnome-sh-99=
9       0dn.h512    0us+:      999:120:R   + [000]      15: 98:R ktimers/=
0=0Agnome-sh-999       0dn.h512   37us : <stack trace>=0A =3D> __ftrace_t=
race_stack=0A =3D> probe_wakeup=0A =3D> ttwu_do_wakeup=0A =3D> try_to_wak=
e_up=0A =3D> raise_timer_softirq=0A =3D> update_process_times=0A =3D> tic=
k_sched_handle=0A =3D> tick_sched_timer=0A =3D> __hrtimer_run_queues=0A =3D=
> hrtimer_interrupt=0A =3D> __sysvec_apic_timer_interrupt=0A =3D> sysvec_=
apic_timer_interrupt=0A =3D> asm_sysvec_apic_timer_interrupt=0A =3D> nati=
ve_apic_mem_read=0A =3D> native_apic_wait_icr_idle=0A =3D> irq_work_queue=
=0A =3D> i915_request_enable_breadcrumb=0A =3D> __dma_fence_enable_signal=
ing=0A =3D> dma_fence_add_callback=0A =3D> i915_sw_fence_await_dma_fence=0A=
 =3D> i915_sw_fence_await_reservation=0A =3D> intel_prepare_plane_fb=0A =3D=
> drm_atomic_helper_prepare_planes=0A =3D> intel_atomic_commit=0A =3D> dr=
m_atomic_helper_page_flip=0A =3D> drm_mode_page_flip_ioctl=0A =3D> drm_io=
ctl_kernel=0A =3D> drm_ioctl=0A =3D> __x64_sys_ioctl=0A =3D> do_syscall_6=
4=0A =3D> entry_SYSCALL_64_after_hwframe=0Agnome-sh-999       0dn.h512   =
37us : 0=0Agnome-sh-999       0dn.h412   39us : task_woken_rt <-ttwu_do_w=
akeup=0Agnome-sh-999       0dn.h412   40us : preempt_count_sub <-try_to_w=
ake_up=0Agnome-sh-999       0dn.h312   40us : _raw_spin_unlock_irqrestore=
 <-try_to_wake_up=0Agnome-sh-999       0dn.h312   40us : preempt_count_su=
b <-_raw_spin_unlock_irqrestore=0Agnome-sh-999       0dn.h212   40us : pr=
eempt_count_sub <-try_to_wake_up=0Agnome-sh-999       0dn.h112   41us : r=
cu_sched_clock_irq <-update_process_times=0Agnome-sh-999       0dn.h112  =
 43us : rcu_is_cpu_rrupt_from_idle <-rcu_sched_clock_irq=0Agnome-sh-999  =
     0dn.h112   45us : rcu_is_cpu_rrupt_from_idle <-rcu_sched_clock_irq=0A=
gnome-sh-999       0dn.h112   46us : rcu_segcblist_ready_cbs <-rcu_sched_=
clock_irq=0Agnome-sh-999       0dn.h112   46us : invoke_rcu_core.part.0 <=
-rcu_sched_clock_irq=0Agnome-sh-999       0dn.h112   48us : wake_up_proce=
ss <-invoke_rcu_core.part.0=0Agnome-sh-999       0dn.h112   48us : try_to=
_wake_up <-invoke_rcu_core.part.0=0Agnome-sh-999       0dn.h112   48us : =
preempt_count_add <-try_to_wake_up=0Agnome-sh-999       0dn.h212   48us :=
 _raw_spin_lock_irqsave <-try_to_wake_up=0Agnome-sh-999       0dn.h212   =
48us : preempt_count_add <-_raw_spin_lock_irqsave=0Agnome-sh-999       0d=
n.h312   49us : kthread_is_per_cpu <-is_cpu_allowed=0Agnome-sh-999       =
0dn.h312   52us : ttwu_queue_wakelist <-try_to_wake_up=0Agnome-sh-999    =
   0dn.h312   52us : preempt_count_add <-try_to_wake_up=0Agnome-sh-999   =
    0dn.h412   52us : _raw_spin_lock <-try_to_wake_up=0Agnome-sh-999     =
  0dn.h412   52us : preempt_count_add <-_raw_spin_lock=0Agnome-sh-999    =
   0dn.h512   52us : preempt_count_sub <-try_to_wake_up=0Agnome-sh-999   =
    0dn.h412   52us : update_rq_clock <-try_to_wake_up=0Agnome-sh-999    =
   0dn.h412   52us : ttwu_do_activate <-try_to_wake_up=0Agnome-sh-999    =
   0dn.h412   53us : psi_task_change <-ttwu_do_activate=0Agnome-sh-999   =
    0dn.h412   53us : psi_flags_change <-psi_task_change=0Agnome-sh-999  =
     0dn.h412   58us : psi_group_change <-ttwu_do_activate=0Agnome-sh-999=
       0dn.h412   58us : enqueue_task_rt <-ttwu_do_activate=0Agnome-sh-99=
9       0dn.h412   58us : dequeue_rt_stack <-enqueue_task_rt=0Agnome-sh-9=
99       0dn.h412   59us : dequeue_top_rt_rq <-dequeue_rt_stack=0Agnome-s=
h-999       0dn.h412   59us : update_rt_migration <-enqueue_task_rt=0Agno=
me-sh-999       0dn.h412   59us : enqueue_top_rt_rq <-enqueue_task_rt=0Ag=
nome-sh-999       0dn.h412   59us : ttwu_do_wakeup <-try_to_wake_up=0Agno=
me-sh-999       0dn.h412   59us : check_preempt_curr <-ttwu_do_wakeup=0Ag=
nome-sh-999       0dn.h412   59us : resched_curr <-check_preempt_curr=0Ag=
nome-sh-999       0dn.h412   61us : task_woken_rt <-ttwu_do_wakeup=0Agnom=
e-sh-999       0dn.h412   61us : preempt_count_sub <-try_to_wake_up=0Agno=
me-sh-999       0dn.h312   62us : _raw_spin_unlock_irqrestore <-try_to_wa=
ke_up=0Agnome-sh-999       0dn.h312   62us : preempt_count_sub <-_raw_spi=
n_unlock_irqrestore=0Agnome-sh-999       0dn.h212   62us : preempt_count_=
sub <-try_to_wake_up=0Agnome-sh-999       0dn.h112   62us : wake_up_proce=
ss <-update_process_times=0Agnome-sh-999       0dn.h112   62us : try_to_w=
ake_up <-update_process_times=0Agnome-sh-999       0dn.h112   62us : pree=
mpt_count_add <-try_to_wake_up=0Agnome-sh-999       0dn.h212   62us : _ra=
w_spin_lock_irqsave <-try_to_wake_up=0Agnome-sh-999       0dn.h212   63us=
 : preempt_count_add <-_raw_spin_lock_irqsave=0Agnome-sh-999       0dn.h3=
12   63us : _raw_spin_unlock_irqrestore <-try_to_wake_up=0Agnome-sh-999  =
     0dn.h312   63us : preempt_count_sub <-_raw_spin_unlock_irqrestore=0A=
gnome-sh-999       0dn.h212   63us : preempt_count_sub <-try_to_wake_up=0A=
gnome-sh-999       0dn.h112   63us : scheduler_tick <-update_process_time=
s=0Agnome-sh-999       0dn.h112   63us : arch_scale_freq_tick <-scheduler=
_tick=0Agnome-sh-999       0dn.h112   65us : preempt_count_add <-schedule=
r_tick=0Agnome-sh-999       0dn.h212   65us : _raw_spin_lock <-scheduler_=
tick=0Agnome-sh-999       0dn.h212   66us : preempt_count_add <-_raw_spin=
_lock=0Agnome-sh-999       0dn.h312   66us : preempt_count_sub <-schedule=
r_tick=0Agnome-sh-999       0dn.h212   66us : update_rq_clock <-scheduler=
_tick=0Agnome-sh-999       0dn.h212   67us : task_tick_fair <-scheduler_t=
ick=0Agnome-sh-999       0dn.h212   68us : update_curr <-task_tick_fair=0A=
gnome-sh-999       0dn.h212   71us : update_min_vruntime <-update_curr=0A=
gnome-sh-999       0dn.h212   72us : cpuacct_charge <-update_curr=0Agnome=
-sh-999       0dn.h212   73us : __cgroup_account_cputime <-update_curr=0A=
gnome-sh-999       0dn.h212   73us : preempt_count_add <-__cgroup_account=
_cputime=0Agnome-sh-999       0dn.h312   73us : cgroup_base_stat_cputime_=
account_end.constprop.0 <-update_curr=0Agnome-sh-999       0dn.h312   73u=
s : cgroup_rstat_updated <-cgroup_base_stat_cputime_account_end.constprop=
.0=0Agnome-sh-999       0dn.h312   73us : preempt_count_sub <-cgroup_base=
_stat_cputime_account_end.constprop.0=0Agnome-sh-999       0dn.h212   77u=
s : __update_load_avg_se <-update_load_avg=0Agnome-sh-999       0dn.h212 =
  78us : __update_load_avg_cfs_rq <-update_load_avg=0Agnome-sh-999       =
0dn.h212   80us : update_cfs_group <-task_tick_fair=0Agnome-sh-999       =
0dn.h212   81us : hrtimer_active <-task_tick_fair=0Agnome-sh-999       0d=
n.h212   82us : update_curr <-task_tick_fair=0Agnome-sh-999       0dn.h21=
2   83us : update_min_vruntime <-update_curr=0Agnome-sh-999       0dn.h21=
2   84us : __update_load_avg_se <-update_load_avg=0Agnome-sh-999       0d=
n.h212   84us : __update_load_avg_cfs_rq <-update_load_avg=0Agnome-sh-999=
       0dn.h212   84us : update_cfs_group <-task_tick_fair=0Agnome-sh-999=
       0dn.h212   85us : reweight_entity <-task_tick_fair=0Agnome-sh-999 =
      0dn.h212   85us : update_curr <-reweight_entity=0Agnome-sh-999     =
  0dn.h212   85us : hrtimer_active <-task_tick_fair=0Agnome-sh-999       =
0dn.h212   85us : sched_slice <-task_tick_fair=0Agnome-sh-999       0dn.h=
212   86us : __calc_delta <-sched_slice=0Agnome-sh-999       0dn.h212   8=
7us : calc_global_load_tick <-scheduler_tick=0Agnome-sh-999       0dn.h21=
2   87us : preempt_count_sub <-scheduler_tick=0Agnome-sh-999       0dn.h1=
12   87us : perf_event_task_tick <-scheduler_tick=0Agnome-sh-999       0d=
n.h112   90us : trigger_load_balance <-update_process_times=0Agnome-sh-99=
9       0dn.h112   91us : run_posix_cpu_timers <-tick_sched_handle=0Agnom=
e-sh-999       0dn.h112   92us : profile_tick <-tick_sched_timer=0Agnome-=
sh-999       0dn.h112   93us : hrtimer_forward <-tick_sched_timer=0Agnome=
-sh-999       0dn.h112   93us : _raw_spin_lock_irq <-__hrtimer_run_queues=
=0Agnome-sh-999       0dn.h112   93us : preempt_count_add <-_raw_spin_loc=
k_irq=0Agnome-sh-999       0dn.h212   94us : enqueue_hrtimer <-__hrtimer_=
run_queues=0Agnome-sh-999       0dn.h212   97us : hrtimer_update_next_eve=
nt <-hrtimer_interrupt=0Agnome-sh-999       0dn.h212   97us : __hrtimer_n=
ext_event_base <-hrtimer_update_next_event=0Agnome-sh-999       0dn.h212 =
  98us : __hrtimer_next_event_base <-hrtimer_update_next_event=0Agnome-sh=
-999       0dn.h212   98us : _raw_spin_unlock_irqrestore <-hrtimer_interr=
upt=0Agnome-sh-999       0dn.h212   98us : preempt_count_sub <-_raw_spin_=
unlock_irqrestore=0Agnome-sh-999       0dn.h112   99us : tick_program_eve=
nt <-hrtimer_interrupt=0Agnome-sh-999       0dn.h112  100us : clockevents=
_program_event <-hrtimer_interrupt=0Agnome-sh-999       0dn.h112  100us :=
 ktime_get <-clockevents_program_event=0Agnome-sh-999       0dn.h112  100=
us : lapic_next_deadline <-clockevents_program_event=0Agnome-sh-999      =
 0dn.h112  101us : irq_exit_rcu <-sysvec_apic_timer_interrupt=0Agnome-sh-=
999       0dn.h112  101us : preempt_count_sub <-__irq_exit_rcu=0Agnome-sh=
-999       0dn..112  101us : wake_up_process <-__irq_exit_rcu=0Agnome-sh-=
999       0dn..112  102us : try_to_wake_up <-__irq_exit_rcu=0Agnome-sh-99=
9       0dn..112  102us : preempt_count_add <-try_to_wake_up=0Agnome-sh-9=
99       0dn..212  102us : _raw_spin_lock_irqsave <-try_to_wake_up=0Agnom=
e-sh-999       0dn..212  102us : preempt_count_add <-_raw_spin_lock_irqsa=
ve=0Agnome-sh-999       0dn..312  102us : _raw_spin_unlock_irqrestore <-t=
ry_to_wake_up=0Agnome-sh-999       0dn..312  102us : preempt_count_sub <-=
_raw_spin_unlock_irqrestore=0Agnome-sh-999       0dn..212  103us : preemp=
t_count_sub <-try_to_wake_up=0Agnome-sh-999       0dn..112  104us : idle_=
cpu <-__irq_exit_rcu=0Agnome-sh-999       0dn..112  105us : raw_irqentry_=
exit_cond_resched <-irqentry_exit=0Agnome-sh-999       0.n..112  106us : =
preempt_count_sub <-irq_work_queue=0Agnome-sh-999       0dn..112  109us :=
 rcu_note_context_switch <-__schedule=0Agnome-sh-999       0dn..112  109u=
s : _raw_spin_lock <-rcu_note_context_switch=0Agnome-sh-999       0dn..11=
2  109us : preempt_count_add <-_raw_spin_lock=0Agnome-sh-999       0dn..2=
12  112us : preempt_count_sub <-rcu_note_context_switch=0Agnome-sh-999   =
    0dn..112  112us : rcu_qs <-rcu_note_context_switch=0Agnome-sh-999    =
   0dn..112  112us : preempt_count_add <-__schedule=0Agnome-sh-999       =
0dn..212  113us : _raw_spin_lock <-__schedule=0Agnome-sh-999       0dn..2=
12  113us : preempt_count_add <-_raw_spin_lock=0Agnome-sh-999       0dn..=
312  113us : preempt_count_sub <-__schedule=0Agnome-sh-999       0dn..212=
  113us : update_rq_clock <-__schedule=0Agnome-sh-999       0dn..212  114=
us : balance_fair <-__schedule=0Agnome-sh-999       0dn..212  114us : put=
_prev_task_fair <-__schedule=0Agnome-sh-999       0dn..212  114us : put_p=
rev_entity <-put_prev_task_fair=0Agnome-sh-999       0dn..212  115us : up=
date_curr <-put_prev_entity=0Agnome-sh-999       0dn..212  115us : __upda=
te_load_avg_se <-update_load_avg=0Agnome-sh-999       0dn..212  116us : _=
_update_load_avg_cfs_rq <-update_load_avg=0Agnome-sh-999       0dn..212  =
116us : put_prev_entity <-put_prev_task_fair=0Agnome-sh-999       0dn..21=
2  116us : update_curr <-put_prev_entity=0Agnome-sh-999       0dn..212  1=
16us : __update_load_avg_se <-update_load_avg=0Agnome-sh-999       0dn..2=
12  116us : __update_load_avg_cfs_rq <-update_load_avg=0Agnome-sh-999    =
   0dn..212  117us : pick_next_task_stop <-__schedule=0Agnome-sh-999     =
  0dn..212  117us : pick_next_task_dl <-__schedule=0Agnome-sh-999       0=
dn..212  118us : pick_next_task_rt <-__schedule=0Agnome-sh-999       0dn.=
.212  119us : update_rt_rq_load_avg <-pick_next_task_rt=0Agnome-sh-999   =
    0d...212  120us : __do_set_cpus_allowed <-__schedule=0Agnome-sh-999  =
     0d...212  122us : dequeue_task_fair <-__do_set_cpus_allowed=0Agnome-=
sh-999       0d...212  123us : dequeue_entity <-dequeue_task_fair=0Agnome=
-sh-999       0d...212  123us : update_curr <-dequeue_entity=0Agnome-sh-9=
99       0d...212  123us : __update_load_avg_se <-update_load_avg=0Agnome=
-sh-999       0d...212  123us : __update_load_avg_cfs_rq <-update_load_av=
g=0Agnome-sh-999       0d...212  124us : clear_buddies <-dequeue_entity=0A=
gnome-sh-999       0d...212  125us : update_cfs_group <-dequeue_entity=0A=
gnome-sh-999       0d...212  125us : dequeue_entity <-dequeue_task_fair=0A=
gnome-sh-999       0d...212  126us : update_curr <-dequeue_entity=0Agnome=
-sh-999       0d...212  126us : __update_load_avg_se <-update_load_avg=0A=
gnome-sh-999       0d...212  126us : __update_load_avg_cfs_rq <-update_lo=
ad_avg=0Agnome-sh-999       0d...212  126us : clear_buddies <-dequeue_ent=
ity=0Agnome-sh-999       0d...212  126us : update_cfs_group <-dequeue_ent=
ity=0Agnome-sh-999       0d...212  126us : reweight_entity <-dequeue_enti=
ty=0Agnome-sh-999       0d...212  127us : hrtick_update <-__do_set_cpus_a=
llowed=0Agnome-sh-999       0d...212  127us : set_cpus_allowed_common <-_=
_do_set_cpus_allowed=0Agnome-sh-999       0d...212  128us : enqueue_task_=
fair <-__schedule=0Agnome-sh-999       0d...212  129us : enqueue_entity <=
-enqueue_task_fair=0Agnome-sh-999       0d...212  129us : update_curr <-e=
nqueue_entity=0Agnome-sh-999       0d...212  130us : __update_load_avg_se=
 <-update_load_avg=0Agnome-sh-999       0d...212  130us : __update_load_a=
vg_cfs_rq <-update_load_avg=0Agnome-sh-999       0d...212  130us : update=
_cfs_group <-enqueue_entity=0Agnome-sh-999       0d...212  131us : enqueu=
e_entity <-enqueue_task_fair=0Agnome-sh-999       0d...212  131us : updat=
e_curr <-enqueue_entity=0Agnome-sh-999       0d...212  131us : __update_l=
oad_avg_se <-update_load_avg=0Agnome-sh-999       0d...212  131us : __upd=
ate_load_avg_cfs_rq <-update_load_avg=0Agnome-sh-999       0d...212  131u=
s : update_cfs_group <-enqueue_entity=0Agnome-sh-999       0d...212  132u=
s : reweight_entity <-enqueue_entity=0Agnome-sh-999       0d...212  132us=
 : se_is_idle <-enqueue_entity=0Agnome-sh-999       0d...212  132us : hrt=
ick_update <-__schedule=0Agnome-sh-999       0d...212  133us : psi_task_s=
witch <-__schedule=0Agnome-sh-999       0d...212  134us : psi_flags_chang=
e <-psi_task_switch=0Agnome-sh-999       0d...212  134us : psi_flags_chan=
ge <-psi_task_switch=0Agnome-sh-999       0d...212  134us : psi_group_cha=
nge <-psi_task_switch=0Agnome-sh-999       0d...212  136us : psi_group_ch=
ange <-psi_task_switch=0Agnome-sh-999       0d...212  138us : psi_group_c=
hange <-psi_task_switch=0Agnome-sh-999       0d...212  143us+: psi_group_=
change <-psi_task_switch=0Agnome-sh-999       0d...212  155us+: psi_group=
_change <-psi_task_switch=0Agnome-sh-999       0d...212  172us+: enter_la=
zy_tlb <-__schedule=0Agnome-sh-999       0d...212  191us : save_fpregs_to=
_fpstate <-__switch_to=0Airq/135--200       0d...2..  200us : finish_task=
_switch.isra.0 <-__schedule=0Airq/135--200       0d...2..  200us : preemp=
t_count_sub <-finish_task_switch.isra.0=0Airq/135--200       0....1..  20=
1us : preempt_count_sub <-schedule=0Airq/135--200       0.......  203us :=
 kthread_should_stop <-irq_thread=0Airq/135--200       0.......  203us : =
irq_thread_check_affinity <-irq_thread=0Airq/135--200       0.......  205=
us : irq_forced_thread_fn <-irq_thread=0Airq/135--200       0.......  205=
us : __local_bh_disable_ip <-irq_forced_thread_fn=0Airq/135--200       0.=
......  205us : migrate_disable <-__local_bh_disable_ip=0Airq/135--200   =
    0.......  205us : preempt_count_add <-migrate_disable=0Airq/135--200 =
      0....111  206us : preempt_count_sub <-migrate_disable=0Airq/135--20=
0       0.....11  206us : rt_spin_lock <-__local_bh_disable_ip=0Airq/135-=
-200       0.....11  206us : __rcu_read_lock <-rt_spin_lock=0Airq/135--20=
0       0.....11  206us : migrate_disable <-__local_bh_disable_ip=0Airq/1=
35--200       0.....12  206us : __rcu_read_lock <-__local_bh_disable_ip=0A=
irq/135--200       0b....12  209us : gen8_irq_handler <-irq_forced_thread=
_fn=0Airq/135--200       0b....12  211us : gen8_gt_irq_handler <-gen8_irq=
_handler=0Airq/135--200       0b....12  213us : execlists_irq_handler <-g=
en8_gt_irq_handler=0Airq/135--200       0b....12  214us : __tasklet_hi_sc=
hedule <-gen8_gt_irq_handler=0Airq/135--200       0b....12  214us : __tas=
klet_schedule_common <-gen8_gt_irq_handler=0Airq/135--200       0D....12 =
 214us : __raise_softirq_irqoff <-__tasklet_schedule_common=0Airq/135--20=
0       0b....12  215us : __local_bh_enable_ip <-irq_forced_thread_fn=0Ai=
rq/135--200       0D....12  216us : __local_bh_enable <-__local_bh_enable=
_ip=0Airq/135--200       0d..s.12  218us : __do_softirq <-__local_bh_enab=
le_ip=0Airq/135--200       0...s.12  219us : tasklet_hi_action <-__do_sof=
tirq=0Airq/135--200       0...s.12  219us : tasklet_action_common.constpr=
op.0 <-__do_softirq=0Airq/135--200       0...s.12  220us : tasklet_clear_=
sched <-tasklet_action_common.constprop.0=0Airq/135--200       0...s.12  =
220us : wake_up_var <-tasklet_clear_sched=0Airq/135--200       0...s.12  =
221us : execlists_submission_tasklet <-tasklet_action_common.constprop.0=0A=
irq/135--200       0...s.12  221us : __rcu_read_lock <-execlists_submissi=
on_tasklet=0Airq/135--200       0...s.12  222us : process_csb <-execlists=
_submission_tasklet=0Airq/135--200       0...s.12  226us : drm_clflush_vi=
rt_range <-process_csb=0Airq/135--200       0...s.12  233us : cancel_time=
r <-process_csb=0Airq/135--200       0...s.12  233us : rt_spin_lock <-exe=
clists_submission_tasklet=0Airq/135--200       0...s.12  233us : __rcu_re=
ad_lock <-rt_spin_lock=0Airq/135--200       0...s.12  233us : migrate_dis=
able <-execlists_submission_tasklet=0Airq/135--200       0...s.13  235us =
: needs_timeslice <-execlists_submission_tasklet=0Airq/135--200       0..=
.s.13  239us : rt_spin_unlock <-execlists_submission_tasklet=0Airq/135--2=
00       0...s.13  239us : migrate_enable <-rt_spin_unlock=0Airq/135--200=
       0...s.12  240us : __rcu_read_unlock <-rt_spin_unlock=0Airq/135--20=
0       0...s.12  240us : needs_timeslice <-execlists_submission_tasklet=0A=
irq/135--200       0...s.12  242us : set_timer_ms <-execlists_submission_=
tasklet=0Airq/135--200       0...s.12  242us : __rcu_read_unlock <-execli=
sts_submission_tasklet=0Airq/135--200       0...s.12  242us : wake_up_var=
 <-tasklet_action_common.constprop.0=0Airq/135--200       0d..s.12  244us=
 : __local_bh_enable <-__local_bh_enable_ip=0Airq/135--200       0d....12=
  244us : __rcu_read_unlock <-__local_bh_enable=0Airq/135--200       0d..=
..12  244us : rt_spin_unlock <-__local_bh_enable=0Airq/135--200       0d.=
...12  244us : migrate_enable <-rt_spin_unlock=0Airq/135--200       0d...=
.11  245us : __rcu_read_unlock <-rt_spin_unlock=0Airq/135--200       0d..=
..11  245us : migrate_enable <-__local_bh_enable_ip=0Airq/135--200       =
0d....11  245us : preempt_count_add <-migrate_enable=0Airq/135--200      =
 0d...1..  248us : preempt_count_sub <-migrate_enable=0Airq/135--200     =
  0.......  248us : __wake_up <-irq_thread=0Airq/135--200       0....... =
 249us : __wake_up_common_lock <-irq_thread=0Airq/135--200       0.......=
  250us : rt_spin_lock <-__wake_up_common_lock=0Airq/135--200       0....=
...  251us : __rcu_read_lock <-rt_spin_lock=0Airq/135--200       0.......=
  251us : migrate_disable <-__wake_up_common_lock=0Airq/135--200       0.=
......  251us : preempt_count_add <-migrate_disable=0Airq/135--200       =
0....111  251us : preempt_count_sub <-migrate_disable=0Airq/135--200     =
  0.....11  252us : __wake_up_common <-__wake_up_common_lock=0Airq/135--2=
00       0.....11  254us : rt_spin_unlock <-__wake_up_common_lock=0Airq/1=
35--200       0.....11  254us : migrate_enable <-rt_spin_unlock=0Airq/135=
--200       0.....11  254us : preempt_count_add <-migrate_enable=0Airq/13=
5--200       0....1..  254us : preempt_count_sub <-migrate_enable=0Airq/1=
35--200       0.......  255us : __rcu_read_unlock <-rt_spin_unlock=0Airq/=
135--200       0.......  255us : kthread_should_stop <-irq_thread=0Airq/1=
35--200       0.......  255us : schedule <-irq_thread=0Airq/135--200     =
  0.......  255us : preempt_count_add <-schedule=0Airq/135--200       0d.=
..1..  256us : rcu_note_context_switch <-__schedule=0Airq/135--200       =
0d...1..  257us : rcu_preempt_deferred_qs <-rcu_note_context_switch=0Airq=
/135--200       0d...1..  257us : rcu_qs <-rcu_note_context_switch=0Airq/=
135--200       0d...1..  257us : preempt_count_add <-__schedule=0Airq/135=
--200       0d...2..  258us : _raw_spin_lock <-__schedule=0Airq/135--200 =
      0d...2..  258us : preempt_count_add <-_raw_spin_lock=0Airq/135--200=
       0d...3..  258us : preempt_count_sub <-__schedule=0Airq/135--200   =
    0d...2..  258us : update_rq_clock <-__schedule=0Airq/135--200       0=
d...2..  260us : dequeue_task_rt <-__schedule=0Airq/135--200       0d...2=
..  260us : update_curr_rt <-dequeue_task_rt=0Airq/135--200       0d...2.=
.  263us : cpuacct_charge <-update_curr_rt=0Airq/135--200       0d...2.. =
 263us : dequeue_rt_stack <-dequeue_task_rt=0Airq/135--200       0d...2..=
  263us : dequeue_top_rt_rq <-dequeue_rt_stack=0Airq/135--200       0d...=
2..  264us : cpupri_set <-dequeue_rt_stack=0Airq/135--200       0d...2.. =
 264us : update_rt_migration <-dequeue_rt_stack=0Airq/135--200       0d..=
.2..  265us : enqueue_top_rt_rq <-dequeue_task_rt=0Airq/135--200       0d=
...2..  265us : balance_rt <-__schedule=0Airq/135--200       0d...2..  26=
5us : pull_rt_task <-balance_rt=0Airq/135--200       0d...2..  266us : pu=
t_prev_task_rt <-__schedule=0Airq/135--200       0d...2..  266us : update=
_curr_rt <-put_prev_task_rt=0Airq/135--200       0d...2..  266us : update=
_rt_rq_load_avg <-put_prev_task_rt=0Airq/135--200       0d...2..  266us :=
 pick_next_task_stop <-__schedule=0Airq/135--200       0d...2..  267us : =
pick_next_task_dl <-__schedule=0Airq/135--200       0d...2..  267us : pic=
k_next_task_rt <-__schedule=0Airq/135--200       0d...2..  270us : psi_ta=
sk_switch <-__schedule=0Airq/135--200       0d...2..  270us : psi_flags_c=
hange <-psi_task_switch=0Airq/135--200       0d...2..  271us : psi_flags_=
change <-psi_task_switch=0Airq/135--200       0d...2..  271us : psi_group=
_change <-psi_task_switch=0Airq/135--200       0d...2..  272us : enter_la=
zy_tlb <-__schedule=0Airq_work-23        0d...2..  275us : finish_task_sw=
itch.isra.0 <-__schedule=0Airq_work-23        0d...2..  275us : preempt_c=
ount_sub <-finish_task_switch.isra.0=0Airq_work-23        0....1..  275us=
 : preempt_count_sub <-schedule=0Airq_work-23        0.......  276us : pr=
eempt_count_add <-smpboot_thread_fn=0Airq_work-23        0....1..  276us =
: kthread_should_stop <-smpboot_thread_fn=0Airq_work-23        0....1..  =
276us : kthread_should_park <-smpboot_thread_fn=0Airq_work-23        0...=
.1..  280us : preempt_count_sub <-smpboot_thread_fn=0Airq_work-23        =
0.......  282us : signal_irq_work <-irq_work_single=0Airq_work-23        =
0.......  282us : ktime_get <-signal_irq_work=0Airq_work-23        0.....=
..  283us : __rcu_read_lock <-signal_irq_work=0Airq_work-23        0.....=
..  284us : __rcu_read_unlock <-signal_irq_work=0Airq_work-23        0...=
....  284us : rt_spin_lock <-signal_irq_work=0Airq_work-23        0......=
.  284us : __rcu_read_lock <-rt_spin_lock=0Airq_work-23        0.......  =
284us : migrate_disable <-signal_irq_work=0Airq_work-23        0.......  =
284us : preempt_count_add <-migrate_disable=0Airq_work-23        0....111=
  285us : preempt_count_sub <-migrate_disable=0Airq_work-23        0.....=
11  286us : irq_enable <-signal_irq_work=0Airq_work-23        0.....11  2=
87us : intel_engine_irq_enable <-signal_irq_work=0Airq_work-23        0..=
...11  287us : rt_spin_lock <-intel_engine_irq_enable=0Airq_work-23      =
  0.....11  287us : __rcu_read_lock <-rt_spin_lock=0Airq_work-23        0=
.....11  287us : migrate_disable <-intel_engine_irq_enable=0Airq_work-23 =
       0.....12  289us : gen8_logical_ring_enable_irq <-intel_engine_irq_=
enable=0Airq_work-23        0.....12  290us : fwtable_write32 <-gen8_logi=
cal_ring_enable_irq=0Airq_work-23        0.....12  291us : rt_spin_lock <=
-fwtable_write32=0Airq_work-23        0.....12  291us : __rcu_read_lock <=
-rt_spin_lock=0Airq_work-23        0.....12  292us : migrate_disable <-fw=
table_write32=0Airq_work-23        0.....13  292us : is_shadowed <-fwtabl=
e_write32=0Airq_work-23        0.....13  293us : find_fw_domain <-fwtable=
_write32=0Airq_work-23        0.....13  295us : ___force_wake_auto <-fwta=
ble_write32=0Airq_work-23        0.....13  296us : hrtimer_start_range_ns=
 <-___force_wake_auto=0Airq_work-23        0.....13  296us : _raw_spin_lo=
ck_irqsave <-hrtimer_start_range_ns=0Airq_work-23        0d....13  297us =
: preempt_count_add <-_raw_spin_lock_irqsave=0Airq_work-23        0d...11=
3  297us : ktime_get <-hrtimer_start_range_ns=0Airq_work-23        0d...1=
13  298us : get_nohz_timer_target <-hrtimer_start_range_ns=0Airq_work-23 =
       0d...113  298us : housekeeping_test_cpu <-get_nohz_timer_target=0A=
irq_work-23        0d...113  298us : enqueue_hrtimer <-hrtimer_start_rang=
e_ns=0Airq_work-23        0d...113  301us : hrtimer_reprogram <-hrtimer_s=
tart_range_ns=0Airq_work-23        0d...113  301us : tick_program_event <=
-hrtimer_start_range_ns=0Airq_work-23        0d...113  302us : clockevent=
s_program_event <-hrtimer_start_range_ns=0Airq_work-23        0d...113  3=
02us : ktime_get <-clockevents_program_event=0Airq_work-23        0d...11=
3  302us : lapic_next_deadline <-clockevents_program_event=0Airq_work-23 =
       0d...113  303us : _raw_spin_unlock_irqrestore <-___force_wake_auto=
=0Airq_work-23        0....113  303us : preempt_count_sub <-_raw_spin_unl=
ock_irqrestore=0Airq_work-23        0.....13  304us : fw_domains_get_with=
_fallback <-fwtable_write32=0Airq_work-23        0.....13  306us : rt_spi=
n_unlock <-gen8_logical_ring_enable_irq=0Airq_work-23        0.....13  30=
6us : migrate_enable <-rt_spin_unlock=0Airq_work-23        0.....12  306u=
s : __rcu_read_unlock <-rt_spin_unlock=0Airq_work-23        0.....12  307=
us : rt_spin_unlock <-intel_engine_irq_enable=0Airq_work-23        0.....=
12  307us : migrate_enable <-rt_spin_unlock=0Airq_work-23        0.....11=
  307us : __rcu_read_unlock <-rt_spin_unlock=0Airq_work-23        0.....1=
1  307us : preempt_count_add <-irq_work_queue=0Airq_work-23        0....1=
11  307us : arch_irq_work_raise <-irq_work_queue=0Airq_work-23        0..=
..111  308us : default_send_IPI_self <-arch_irq_work_raise=0Airq_work-23 =
       0d...111  309us : irq_enter_rcu <-sysvec_irq_work=0Airq_work-23   =
     0d...111  310us : preempt_count_add <-irq_enter_rcu=0Airq_work-23   =
     0d..h111  311us : __sysvec_irq_work <-sysvec_irq_work=0Airq_work-23 =
       0d..h111  311us : wake_up_process <-__sysvec_irq_work=0Airq_work-2=
3        0d..h111  312us : try_to_wake_up <-__sysvec_irq_work=0Airq_work-=
23        0d..h111  312us : preempt_count_add <-try_to_wake_up=0Airq_work=
-23        0d..h211  312us : preempt_count_sub <-try_to_wake_up=0Airq_wor=
k-23        0d..h111  314us : irq_exit_rcu <-sysvec_irq_work=0Airq_work-2=
3        0d..h111  314us : preempt_count_sub <-__irq_exit_rcu=0Airq_work-=
23        0d...111  315us : wake_up_process <-__irq_exit_rcu=0Airq_work-2=
3        0d...111  315us : try_to_wake_up <-__irq_exit_rcu=0Airq_work-23 =
       0d...111  315us : preempt_count_add <-try_to_wake_up=0Airq_work-23=
        0d...211  315us : _raw_spin_lock_irqsave <-try_to_wake_up=0Airq_w=
ork-23        0d...211  316us : preempt_count_add <-_raw_spin_lock_irqsav=
e=0Airq_work-23        0d...311  316us : _raw_spin_unlock_irqrestore <-tr=
y_to_wake_up=0Airq_work-23        0d...311  316us : preempt_count_sub <-_=
raw_spin_unlock_irqrestore=0Airq_work-23        0d...211  316us : preempt=
_count_sub <-try_to_wake_up=0Airq_work-23        0d...111  316us : idle_c=
pu <-__irq_exit_rcu=0Airq_work-23        0d...111  316us : raw_irqentry_e=
xit_cond_resched <-irqentry_exit=0Airq_work-23        0....111  319us : n=
ative_apic_wait_icr_idle <-irq_work_queue=0Airq_work-23        0....111  =
319us : preempt_count_sub <-irq_work_queue=0Airq_work-23        0.....11 =
 320us : rt_spin_unlock <-irq_work_single=0Airq_work-23        0.....11  =
320us : migrate_enable <-rt_spin_unlock=0Airq_work-23        0.....11  32=
0us : preempt_count_add <-migrate_enable=0Airq_work-23        0....1..  3=
20us : preempt_count_sub <-migrate_enable=0Airq_work-23        0.......  =
320us : __rcu_read_unlock <-rt_spin_unlock=0Airq_work-23        0....... =
 321us : rcuwait_wake_up <-run_irq_workd=0Airq_work-23        0.......  3=
21us : __rcu_read_lock <-rcuwait_wake_up=0Airq_work-23        0.......  3=
21us : __rcu_read_unlock <-rcuwait_wake_up=0Airq_work-23        0....... =
 322us : preempt_count_add <-smpboot_thread_fn=0Airq_work-23        0....=
1..  322us : kthread_should_stop <-smpboot_thread_fn=0Airq_work-23       =
 0....1..  322us : kthread_should_park <-smpboot_thread_fn=0Airq_work-23 =
       0....1..  322us : preempt_count_sub <-smpboot_thread_fn=0Airq_work=
-23        0.......  322us : signal_irq_work <-irq_work_single=0Airq_work=
-23        0.......  322us : ktime_get <-signal_irq_work=0Airq_work-23   =
     0.......  323us : __rcu_read_lock <-signal_irq_work=0Airq_work-23   =
     0.......  323us : __rcu_read_unlock <-signal_irq_work=0Airq_work-23 =
       0.......  323us : rcuwait_wake_up <-run_irq_workd=0Airq_work-23   =
     0.......  323us : __rcu_read_lock <-rcuwait_wake_up=0Airq_work-23   =
     0.......  323us : __rcu_read_unlock <-rcuwait_wake_up=0Airq_work-23 =
       0.......  323us : preempt_count_add <-smpboot_thread_fn=0Airq_work=
-23        0....1..  323us : kthread_should_stop <-smpboot_thread_fn=0Air=
q_work-23        0....1..  324us : kthread_should_park <-smpboot_thread_f=
n=0Airq_work-23        0....1..  324us : preempt_count_sub <-smpboot_thre=
ad_fn=0Airq_work-23        0.......  324us : schedule <-smpboot_thread_fn=
=0Airq_work-23        0.......  324us : preempt_count_add <-schedule=0Air=
q_work-23        0d...1..  325us : rcu_note_context_switch <-__schedule=0A=
irq_work-23        0d...1..  325us : rcu_preempt_deferred_qs <-rcu_note_c=
ontext_switch=0Airq_work-23        0d...1..  325us : rcu_qs <-rcu_note_co=
ntext_switch=0Airq_work-23        0d...1..  325us : preempt_count_add <-_=
_schedule=0Airq_work-23        0d...2..  325us : _raw_spin_lock <-__sched=
ule=0Airq_work-23        0d...2..  326us : preempt_count_add <-_raw_spin_=
lock=0Airq_work-23        0d...3..  326us : preempt_count_sub <-__schedul=
e=0Airq_work-23        0d...2..  326us : update_rq_clock <-__schedule=0Ai=
rq_work-23        0d...2..  327us : dequeue_task_rt <-__schedule=0Airq_wo=
rk-23        0d...2..  327us : update_curr_rt <-dequeue_task_rt=0Airq_wor=
k-23        0d...2..  329us : cpuacct_charge <-update_curr_rt=0Airq_work-=
23        0d...2..  330us : dequeue_rt_stack <-dequeue_task_rt=0Airq_work=
-23        0d...2..  330us : dequeue_top_rt_rq <-dequeue_rt_stack=0Airq_w=
ork-23        0d...2..  331us : update_rt_migration <-dequeue_rt_stack=0A=
irq_work-23        0d...2..  331us : enqueue_top_rt_rq <-dequeue_task_rt=0A=
irq_work-23        0d...2..  331us : balance_rt <-__schedule=0Airq_work-2=
3        0d...2..  332us : put_prev_task_rt <-__schedule=0Airq_work-23   =
     0d...2..  332us : update_curr_rt <-put_prev_task_rt=0Airq_work-23   =
     0d...2..  332us : update_rt_rq_load_avg <-put_prev_task_rt=0Airq_wor=
k-23        0d...2..  332us : pick_next_task_stop <-__schedule=0Airq_work=
-23        0d...2..  332us : pick_next_task_dl <-__schedule=0Airq_work-23=
        0d...2..  332us : pick_next_task_rt <-__schedule=0Airq_work-23   =
     0d...2..  333us : psi_task_switch <-__schedule=0Airq_work-23        =
0d...2..  334us : psi_flags_change <-psi_task_switch=0Airq_work-23       =
 0d...2..  334us : psi_flags_change <-psi_task_switch=0Airq_work-23      =
  0d...2..  334us : psi_group_change <-psi_task_switch=0Airq_work-23     =
   0d...3..  335us : __schedule=0Airq_work-23        0d...3..  336us+:   =
    23: 98:S =3D=3D> [000]      15: 98:R ktimers/0=0Airq_work-23        0=
d...3..  357us : <stack trace>=0A =3D> __ftrace_trace_stack=0A =3D> probe=
_wakeup_sched_switch=0A =3D> __schedule=0A =3D> schedule=0A =3D> smpboot_=
thread_fn=0A =3D> kthread=0A =3D> ret_from_fork=0A
--_=__=_XaM3_.1695659445.2A.32770.42.23554.52.42.007.698192834
Content-Type: text/plain; name="=?utf-8?Q?config-5.19.0-rt10?="
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="=?utf-8?Q?config-5.19.0-rt10?="

#=0A# Automatically generated file; DO NOT EDIT.=0A# Linux/x86 5.19.0 Ker=
nel Configuration=0A#=0ACONFIG_CC_VERSION_TEXT=3D"gcc (Debian 10.2.1-6) 1=
0.2.1 20210110"=0ACONFIG_CC_IS_GCC=3Dy=0ACONFIG_GCC_VERSION=3D100201=0ACO=
NFIG_CLANG_VERSION=3D0=0ACONFIG_AS_IS_GNU=3Dy=0ACONFIG_AS_VERSION=3D23502=
=0ACONFIG_LD_IS_BFD=3Dy=0ACONFIG_LD_VERSION=3D23502=0ACONFIG_LLD_VERSION=3D=
0=0ACONFIG_CC_CAN_LINK=3Dy=0ACONFIG_CC_CAN_LINK_STATIC=3Dy=0ACONFIG_CC_HA=
S_ASM_GOTO=3Dy=0ACONFIG_CC_HAS_ASM_INLINE=3Dy=0ACONFIG_CC_HAS_NO_PROFILE_=
FN_ATTR=3Dy=0ACONFIG_PAHOLE_VERSION=3D120=0ACONFIG_IRQ_WORK=3Dy=0ACONFIG_=
BUILDTIME_TABLE_SORT=3Dy=0ACONFIG_THREAD_INFO_IN_TASK=3Dy=0A=0A#=0A# Gene=
ral setup=0A#=0ACONFIG_INIT_ENV_ARG_LIMIT=3D32=0A# CONFIG_COMPILE_TEST is=
 not set=0A# CONFIG_WERROR is not set=0ACONFIG_LOCALVERSION=3D""=0A# CONF=
IG_LOCALVERSION_AUTO is not set=0ACONFIG_BUILD_SALT=3D""=0ACONFIG_HAVE_KE=
RNEL_GZIP=3Dy=0ACONFIG_HAVE_KERNEL_BZIP2=3Dy=0ACONFIG_HAVE_KERNEL_LZMA=3D=
y=0ACONFIG_HAVE_KERNEL_XZ=3Dy=0ACONFIG_HAVE_KERNEL_LZO=3Dy=0ACONFIG_HAVE_=
KERNEL_LZ4=3Dy=0ACONFIG_HAVE_KERNEL_ZSTD=3Dy=0A# CONFIG_KERNEL_GZIP is no=
t set=0A# CONFIG_KERNEL_BZIP2 is not set=0A# CONFIG_KERNEL_LZMA is not se=
t=0ACONFIG_KERNEL_XZ=3Dy=0A# CONFIG_KERNEL_LZO is not set=0A# CONFIG_KERN=
EL_LZ4 is not set=0A# CONFIG_KERNEL_ZSTD is not set=0ACONFIG_DEFAULT_INIT=
=3D""=0ACONFIG_DEFAULT_HOSTNAME=3D"(none)"=0ACONFIG_SYSVIPC=3Dy=0ACONFIG_=
SYSVIPC_SYSCTL=3Dy=0ACONFIG_SYSVIPC_COMPAT=3Dy=0ACONFIG_POSIX_MQUEUE=3Dy=0A=
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy=0A# CONFIG_WATCH_QUEUE is not set=0ACONFIG=
_CROSS_MEMORY_ATTACH=3Dy=0ACONFIG_USELIB=3Dy=0ACONFIG_AUDIT=3Dy=0ACONFIG_=
HAVE_ARCH_AUDITSYSCALL=3Dy=0ACONFIG_AUDITSYSCALL=3Dy=0A=0A#=0A# IRQ subsy=
stem=0A#=0ACONFIG_GENERIC_IRQ_PROBE=3Dy=0ACONFIG_GENERIC_IRQ_SHOW=3Dy=0AC=
ONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy=0ACONFIG_GENERIC_PENDING_IRQ=3Dy=
=0ACONFIG_GENERIC_IRQ_MIGRATION=3Dy=0ACONFIG_HARDIRQS_SW_RESEND=3Dy=0ACON=
FIG_IRQ_DOMAIN=3Dy=0ACONFIG_IRQ_DOMAIN_HIERARCHY=3Dy=0ACONFIG_GENERIC_MSI=
_IRQ=3Dy=0ACONFIG_GENERIC_MSI_IRQ_DOMAIN=3Dy=0ACONFIG_IRQ_MSI_IOMMU=3Dy=0A=
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy=0ACONFIG_GENERIC_IRQ_RESERVATION_=
MODE=3Dy=0ACONFIG_IRQ_FORCED_THREADING=3Dy=0ACONFIG_SPARSE_IRQ=3Dy=0A# CO=
NFIG_GENERIC_IRQ_DEBUGFS is not set=0A# end of IRQ subsystem=0A=0ACONFIG_=
CLOCKSOURCE_WATCHDOG=3Dy=0ACONFIG_ARCH_CLOCKSOURCE_INIT=3Dy=0ACONFIG_CLOC=
KSOURCE_VALIDATE_LAST_CYCLE=3Dy=0ACONFIG_GENERIC_TIME_VSYSCALL=3Dy=0ACONF=
IG_GENERIC_CLOCKEVENTS=3Dy=0ACONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy=0AC=
ONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy=0ACONFIG_GENERIC_CMOS_UPDATE=3Dy=
=0ACONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=3Dy=0ACONFIG_POSIX_CPU_TIMERS_T=
ASK_WORK=3Dy=0A=0A#=0A# Timers subsystem=0A#=0ACONFIG_TICK_ONESHOT=3Dy=0A=
CONFIG_NO_HZ_COMMON=3Dy=0A# CONFIG_HZ_PERIODIC is not set=0A# CONFIG_NO_H=
Z_IDLE is not set=0ACONFIG_NO_HZ_FULL=3Dy=0ACONFIG_CONTEXT_TRACKING=3Dy=0A=
# CONFIG_CONTEXT_TRACKING_FORCE is not set=0ACONFIG_NO_HZ=3Dy=0ACONFIG_HI=
GH_RES_TIMERS=3Dy=0ACONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=3D100=0A# end=
 of Timers subsystem=0A=0ACONFIG_BPF=3Dy=0ACONFIG_HAVE_EBPF_JIT=3Dy=0ACON=
FIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy=0A=0A#=0A# BPF subsystem=0A#=0ACONFIG_B=
PF_SYSCALL=3Dy=0ACONFIG_BPF_JIT=3Dy=0A# CONFIG_BPF_JIT_ALWAYS_ON is not s=
et=0ACONFIG_BPF_JIT_DEFAULT_ON=3Dy=0A# CONFIG_BPF_UNPRIV_DEFAULT_OFF is n=
ot set=0A# CONFIG_BPF_PRELOAD is not set=0A# CONFIG_BPF_LSM is not set=0A=
# end of BPF subsystem=0A=0ACONFIG_HAVE_PREEMPT_LAZY=3Dy=0ACONFIG_PREEMPT=
_LAZY=3Dy=0A# CONFIG_PREEMPT_NONE is not set=0A# CONFIG_PREEMPT_VOLUNTARY=
 is not set=0A# CONFIG_PREEMPT is not set=0ACONFIG_PREEMPT_RT=3Dy=0ACONFI=
G_PREEMPT_COUNT=3Dy=0ACONFIG_PREEMPTION=3Dy=0A# CONFIG_SCHED_CORE is not =
set=0A=0A#=0A# CPU/Task time and stats accounting=0A#=0ACONFIG_VIRT_CPU_A=
CCOUNTING=3Dy=0ACONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy=0A# CONFIG_IRQ_TIME_AC=
COUNTING is not set=0ACONFIG_BSD_PROCESS_ACCT=3Dy=0ACONFIG_BSD_PROCESS_AC=
CT_V3=3Dy=0ACONFIG_TASKSTATS=3Dy=0ACONFIG_TASK_DELAY_ACCT=3Dy=0ACONFIG_TA=
SK_XACCT=3Dy=0ACONFIG_TASK_IO_ACCOUNTING=3Dy=0ACONFIG_PSI=3Dy=0A# CONFIG_=
PSI_DEFAULT_DISABLED is not set=0A# end of CPU/Task time and stats accoun=
ting=0A=0ACONFIG_CPU_ISOLATION=3Dy=0A=0A#=0A# RCU Subsystem=0A#=0ACONFIG_=
TREE_RCU=3Dy=0ACONFIG_PREEMPT_RCU=3Dy=0A# CONFIG_RCU_EXPERT is not set=0A=
CONFIG_SRCU=3Dy=0ACONFIG_TREE_SRCU=3Dy=0ACONFIG_TASKS_RCU_GENERIC=3Dy=0AC=
ONFIG_TASKS_RCU=3Dy=0ACONFIG_TASKS_RUDE_RCU=3Dy=0ACONFIG_TASKS_TRACE_RCU=3D=
y=0ACONFIG_RCU_STALL_COMMON=3Dy=0ACONFIG_RCU_NEED_SEGCBLIST=3Dy=0ACONFIG_=
RCU_BOOST=3Dy=0ACONFIG_RCU_BOOST_DELAY=3D500=0ACONFIG_RCU_NOCB_CPU=3Dy=0A=
# end of RCU Subsystem=0A=0ACONFIG_BUILD_BIN2C=3Dy=0ACONFIG_IKCONFIG=3Dm=0A=
# CONFIG_IKCONFIG_PROC is not set=0A# CONFIG_IKHEADERS is not set=0ACONFI=
G_LOG_BUF_SHIFT=3D17=0ACONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12=0ACONFIG_PRINTK_=
SAFE_LOG_BUF_SHIFT=3D13=0A# CONFIG_PRINTK_INDEX is not set=0ACONFIG_HAVE_=
UNSTABLE_SCHED_CLOCK=3Dy=0A=0A#=0A# Scheduler features=0A#=0A# CONFIG_UCL=
AMP_TASK is not set=0A# end of Scheduler features=0A=0ACONFIG_ARCH_SUPPOR=
TS_NUMA_BALANCING=3Dy=0ACONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy=0ACO=
NFIG_CC_HAS_INT128=3Dy=0ACONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-Wimplicit-fal=
lthrough=3D5"=0ACONFIG_GCC12_NO_ARRAY_BOUNDS=3Dy=0ACONFIG_ARCH_SUPPORTS_I=
NT128=3Dy=0ACONFIG_CGROUPS=3Dy=0ACONFIG_PAGE_COUNTER=3Dy=0ACONFIG_MEMCG=3D=
y=0ACONFIG_MEMCG_SWAP=3Dy=0ACONFIG_MEMCG_KMEM=3Dy=0ACONFIG_BLK_CGROUP=3Dy=
=0ACONFIG_CGROUP_WRITEBACK=3Dy=0ACONFIG_CGROUP_SCHED=3Dy=0ACONFIG_FAIR_GR=
OUP_SCHED=3Dy=0ACONFIG_CFS_BANDWIDTH=3Dy=0A# CONFIG_RT_GROUP_SCHED is not=
 set=0ACONFIG_CGROUP_PIDS=3Dy=0ACONFIG_CGROUP_RDMA=3Dy=0ACONFIG_CGROUP_FR=
EEZER=3Dy=0ACONFIG_CGROUP_HUGETLB=3Dy=0ACONFIG_CPUSETS=3Dy=0ACONFIG_PROC_=
PID_CPUSET=3Dy=0ACONFIG_CGROUP_DEVICE=3Dy=0ACONFIG_CGROUP_CPUACCT=3Dy=0AC=
ONFIG_CGROUP_PERF=3Dy=0ACONFIG_CGROUP_BPF=3Dy=0A# CONFIG_CGROUP_MISC is n=
ot set=0A# CONFIG_CGROUP_DEBUG is not set=0ACONFIG_SOCK_CGROUP_DATA=3Dy=0A=
CONFIG_NAMESPACES=3Dy=0ACONFIG_UTS_NS=3Dy=0ACONFIG_TIME_NS=3Dy=0ACONFIG_I=
PC_NS=3Dy=0ACONFIG_USER_NS=3Dy=0ACONFIG_PID_NS=3Dy=0ACONFIG_NET_NS=3Dy=0A=
CONFIG_CHECKPOINT_RESTORE=3Dy=0ACONFIG_SCHED_AUTOGROUP=3Dy=0A# CONFIG_SYS=
FS_DEPRECATED is not set=0ACONFIG_RELAY=3Dy=0ACONFIG_BLK_DEV_INITRD=3Dy=0A=
CONFIG_INITRAMFS_SOURCE=3D""=0ACONFIG_RD_GZIP=3Dy=0ACONFIG_RD_BZIP2=3Dy=0A=
CONFIG_RD_LZMA=3Dy=0ACONFIG_RD_XZ=3Dy=0ACONFIG_RD_LZO=3Dy=0ACONFIG_RD_LZ4=
=3Dy=0ACONFIG_RD_ZSTD=3Dy=0A# CONFIG_BOOT_CONFIG is not set=0ACONFIG_INIT=
RAMFS_PRESERVE_MTIME=3Dy=0ACONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy=0A# CON=
FIG_CC_OPTIMIZE_FOR_SIZE is not set=0ACONFIG_LD_ORPHAN_WARN=3Dy=0ACONFIG_=
SYSCTL=3Dy=0ACONFIG_HAVE_UID16=3Dy=0ACONFIG_SYSCTL_EXCEPTION_TRACE=3Dy=0A=
CONFIG_HAVE_PCSPKR_PLATFORM=3Dy=0ACONFIG_EXPERT=3Dy=0ACONFIG_UID16=3Dy=0A=
CONFIG_MULTIUSER=3Dy=0ACONFIG_SGETMASK_SYSCALL=3Dy=0ACONFIG_SYSFS_SYSCALL=
=3Dy=0ACONFIG_FHANDLE=3Dy=0ACONFIG_POSIX_TIMERS=3Dy=0ACONFIG_PRINTK=3Dy=0A=
CONFIG_HAVE_ATOMIC_CONSOLE=3Dy=0ACONFIG_BUG=3Dy=0ACONFIG_ELF_CORE=3Dy=0AC=
ONFIG_PCSPKR_PLATFORM=3Dy=0ACONFIG_BASE_FULL=3Dy=0ACONFIG_FUTEX=3Dy=0ACON=
FIG_FUTEX_PI=3Dy=0ACONFIG_EPOLL=3Dy=0ACONFIG_SIGNALFD=3Dy=0ACONFIG_TIMERF=
D=3Dy=0ACONFIG_EVENTFD=3Dy=0ACONFIG_SHMEM=3Dy=0ACONFIG_AIO=3Dy=0ACONFIG_I=
O_URING=3Dy=0ACONFIG_ADVISE_SYSCALLS=3Dy=0ACONFIG_MEMBARRIER=3Dy=0ACONFIG=
_KALLSYMS=3Dy=0ACONFIG_KALLSYMS_ALL=3Dy=0ACONFIG_KALLSYMS_ABSOLUTE_PERCPU=
=3Dy=0ACONFIG_KALLSYMS_BASE_RELATIVE=3Dy=0ACONFIG_ARCH_HAS_MEMBARRIER_SYN=
C_CORE=3Dy=0ACONFIG_KCMP=3Dy=0ACONFIG_RSEQ=3Dy=0A# CONFIG_DEBUG_RSEQ is n=
ot set=0A# CONFIG_EMBEDDED is not set=0ACONFIG_HAVE_PERF_EVENTS=3Dy=0A# C=
ONFIG_PC104 is not set=0A=0A#=0A# Kernel Performance Events And Counters=0A=
#=0ACONFIG_PERF_EVENTS=3Dy=0A# CONFIG_DEBUG_PERF_USE_VMALLOC is not set=0A=
# end of Kernel Performance Events And Counters=0A=0ACONFIG_SYSTEM_DATA_V=
ERIFICATION=3Dy=0ACONFIG_PROFILING=3Dy=0ACONFIG_TRACEPOINTS=3Dy=0A# end o=
f General setup=0A=0ACONFIG_64BIT=3Dy=0ACONFIG_X86_64=3Dy=0ACONFIG_X86=3D=
y=0ACONFIG_INSTRUCTION_DECODER=3Dy=0ACONFIG_OUTPUT_FORMAT=3D"elf64-x86-64=
"=0ACONFIG_LOCKDEP_SUPPORT=3Dy=0ACONFIG_STACKTRACE_SUPPORT=3Dy=0ACONFIG_M=
MU=3Dy=0ACONFIG_ARCH_MMAP_RND_BITS_MIN=3D28=0ACONFIG_ARCH_MMAP_RND_BITS_M=
AX=3D32=0ACONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8=0ACONFIG_ARCH_MMAP_RND=
_COMPAT_BITS_MAX=3D16=0ACONFIG_GENERIC_ISA_DMA=3Dy=0ACONFIG_GENERIC_BUG=3D=
y=0ACONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy=0ACONFIG_ARCH_MAY_HAVE_PC_FD=
C=3Dy=0ACONFIG_GENERIC_CALIBRATE_DELAY=3Dy=0ACONFIG_ARCH_HAS_CPU_RELAX=3D=
y=0ACONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy=0ACONFIG_ARCH_NR_GPIO=3D1024=0AC=
ONFIG_ARCH_SUSPEND_POSSIBLE=3Dy=0ACONFIG_AUDIT_ARCH=3Dy=0ACONFIG_HAVE_INT=
EL_TXT=3Dy=0ACONFIG_X86_64_SMP=3Dy=0ACONFIG_ARCH_SUPPORTS_UPROBES=3Dy=0AC=
ONFIG_FIX_EARLYCON_MEM=3Dy=0ACONFIG_PGTABLE_LEVELS=3D4=0ACONFIG_CC_HAS_SA=
NE_STACKPROTECTOR=3Dy=0A=0A#=0A# Processor type and features=0A#=0ACONFIG=
_SMP=3Dy=0ACONFIG_X86_FEATURE_NAMES=3Dy=0A# CONFIG_X86_X2APIC is not set=0A=
CONFIG_X86_MPPARSE=3Dy=0A# CONFIG_GOLDFISH is not set=0ACONFIG_X86_CPU_RE=
SCTRL=3Dy=0A# CONFIG_X86_EXTENDED_PLATFORM is not set=0ACONFIG_X86_INTEL_=
LPSS=3Dy=0ACONFIG_X86_AMD_PLATFORM_DEVICE=3Dy=0ACONFIG_IOSF_MBI=3Dy=0A# C=
ONFIG_IOSF_MBI_DEBUG is not set=0ACONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy=0A=
CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy=0ACONFIG_HYPERVISOR_GUEST=3Dy=0A# CON=
FIG_PARAVIRT is not set=0ACONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy=0ACONFIG_PVH=3D=
y=0A# CONFIG_JAILHOUSE_GUEST is not set=0A# CONFIG_ACRN_GUEST is not set=0A=
# CONFIG_MK8 is not set=0A# CONFIG_MPSC is not set=0ACONFIG_MCORE2=3Dy=0A=
# CONFIG_MATOM is not set=0A# CONFIG_GENERIC_CPU is not set=0ACONFIG_X86_=
INTERNODE_CACHE_SHIFT=3D6=0ACONFIG_X86_L1_CACHE_SHIFT=3D6=0ACONFIG_X86_IN=
TEL_USERCOPY=3Dy=0ACONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0ACONFIG_X86_P6_NOP=3D=
y=0ACONFIG_X86_TSC=3Dy=0ACONFIG_X86_CMPXCHG64=3Dy=0ACONFIG_X86_CMOV=3Dy=0A=
CONFIG_X86_MINIMUM_CPU_FAMILY=3D64=0ACONFIG_X86_DEBUGCTLMSR=3Dy=0ACONFIG_=
IA32_FEAT_CTL=3Dy=0ACONFIG_X86_VMX_FEATURE_NAMES=3Dy=0A# CONFIG_PROCESSOR=
_SELECT is not set=0ACONFIG_CPU_SUP_INTEL=3Dy=0ACONFIG_CPU_SUP_AMD=3Dy=0A=
CONFIG_CPU_SUP_HYGON=3Dy=0ACONFIG_CPU_SUP_CENTAUR=3Dy=0ACONFIG_CPU_SUP_ZH=
AOXIN=3Dy=0ACONFIG_HPET_TIMER=3Dy=0ACONFIG_HPET_EMULATE_RTC=3Dy=0ACONFIG_=
DMI=3Dy=0ACONFIG_GART_IOMMU=3Dy=0ACONFIG_BOOT_VESA_SUPPORT=3Dy=0A# CONFIG=
_MAXSMP is not set=0ACONFIG_NR_CPUS_RANGE_BEGIN=3D2=0ACONFIG_NR_CPUS_RANG=
E_END=3D512=0ACONFIG_NR_CPUS_DEFAULT=3D64=0ACONFIG_NR_CPUS=3D6=0ACONFIG_S=
CHED_CLUSTER=3Dy=0ACONFIG_SCHED_SMT=3Dy=0ACONFIG_SCHED_MC=3Dy=0ACONFIG_SC=
HED_MC_PRIO=3Dy=0ACONFIG_X86_LOCAL_APIC=3Dy=0ACONFIG_X86_IO_APIC=3Dy=0ACO=
NFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy=0ACONFIG_X86_MCE=3Dy=0A# CONFIG=
_X86_MCELOG_LEGACY is not set=0ACONFIG_X86_MCE_INTEL=3Dy=0ACONFIG_X86_MCE=
_AMD=3Dy=0ACONFIG_X86_MCE_THRESHOLD=3Dy=0A# CONFIG_X86_MCE_INJECT is not =
set=0A=0A#=0A# Performance monitoring=0A#=0A# CONFIG_PERF_EVENTS_INTEL_UN=
CORE is not set=0A# CONFIG_PERF_EVENTS_INTEL_RAPL is not set=0ACONFIG_PER=
F_EVENTS_INTEL_CSTATE=3Dm=0A# CONFIG_PERF_EVENTS_AMD_POWER is not set=0AC=
ONFIG_PERF_EVENTS_AMD_UNCORE=3Dy=0A# CONFIG_PERF_EVENTS_AMD_BRS is not se=
t=0A# end of Performance monitoring=0A=0ACONFIG_X86_16BIT=3Dy=0ACONFIG_X8=
6_ESPFIX64=3Dy=0ACONFIG_X86_VSYSCALL_EMULATION=3Dy=0ACONFIG_X86_IOPL_IOPE=
RM=3Dy=0ACONFIG_MICROCODE=3Dy=0ACONFIG_MICROCODE_INTEL=3Dy=0ACONFIG_MICRO=
CODE_AMD=3Dy=0A# CONFIG_MICROCODE_LATE_LOADING is not set=0ACONFIG_X86_MS=
R=3Dm=0A# CONFIG_X86_CPUID is not set=0A# CONFIG_X86_5LEVEL is not set=0A=
CONFIG_X86_DIRECT_GBPAGES=3Dy=0A# CONFIG_X86_CPA_STATISTICS is not set=0A=
# CONFIG_AMD_MEM_ENCRYPT is not set=0ACONFIG_NUMA=3Dy=0ACONFIG_AMD_NUMA=3D=
y=0ACONFIG_X86_64_ACPI_NUMA=3Dy=0ACONFIG_NUMA_EMU=3Dy=0ACONFIG_NODES_SHIF=
T=3D10=0ACONFIG_ARCH_SPARSEMEM_ENABLE=3Dy=0ACONFIG_ARCH_SPARSEMEM_DEFAULT=
=3Dy=0A# CONFIG_ARCH_MEMORY_PROBE is not set=0ACONFIG_ARCH_PROC_KCORE_TEX=
T=3Dy=0ACONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000=0A# CONFIG_X86_=
PMEM_LEGACY is not set=0A# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set=0A=
CONFIG_MTRR=3Dy=0ACONFIG_MTRR_SANITIZER=3Dy=0ACONFIG_MTRR_SANITIZER_ENABL=
E_DEFAULT=3D0=0ACONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1=0ACONFIG_X=
86_PAT=3Dy=0ACONFIG_ARCH_USES_PG_UNCACHED=3Dy=0ACONFIG_ARCH_RANDOM=3Dy=0A=
CONFIG_X86_UMIP=3Dy=0ACONFIG_CC_HAS_IBT=3Dy=0A# CONFIG_X86_KERNEL_IBT is =
not set=0ACONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy=0ACONFIG_X86_INTEL_=
TSX_MODE_OFF=3Dy=0A# CONFIG_X86_INTEL_TSX_MODE_ON is not set=0A# CONFIG_X=
86_INTEL_TSX_MODE_AUTO is not set=0A# CONFIG_X86_SGX is not set=0ACONFIG_=
EFI=3Dy=0ACONFIG_EFI_STUB=3Dy=0ACONFIG_EFI_MIXED=3Dy=0A# CONFIG_HZ_100 is=
 not set=0ACONFIG_HZ_250=3Dy=0A# CONFIG_HZ_300 is not set=0A# CONFIG_HZ_1=
000 is not set=0ACONFIG_HZ=3D250=0ACONFIG_SCHED_HRTICK=3Dy=0ACONFIG_KEXEC=
=3Dy=0ACONFIG_KEXEC_FILE=3Dy=0ACONFIG_ARCH_HAS_KEXEC_PURGATORY=3Dy=0ACONF=
IG_KEXEC_SIG=3Dy=0A# CONFIG_KEXEC_SIG_FORCE is not set=0ACONFIG_KEXEC_BZI=
MAGE_VERIFY_SIG=3Dy=0ACONFIG_CRASH_DUMP=3Dy=0A# CONFIG_KEXEC_JUMP is not =
set=0ACONFIG_PHYSICAL_START=3D0x1000000=0ACONFIG_RELOCATABLE=3Dy=0ACONFIG=
_RANDOMIZE_BASE=3Dy=0ACONFIG_X86_NEED_RELOCS=3Dy=0ACONFIG_PHYSICAL_ALIGN=3D=
0x200000=0ACONFIG_DYNAMIC_MEMORY_LAYOUT=3Dy=0ACONFIG_RANDOMIZE_MEMORY=3Dy=
=0ACONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=3D0xa=0ACONFIG_HOTPLUG_CPU=3D=
y=0A# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set=0A# CONFIG_DEBUG_HOTPLUG_C=
PU0 is not set=0A# CONFIG_COMPAT_VDSO is not set=0A# CONFIG_LEGACY_VSYSCA=
LL_XONLY is not set=0ACONFIG_LEGACY_VSYSCALL_NONE=3Dy=0A# CONFIG_CMDLINE_=
BOOL is not set=0ACONFIG_MODIFY_LDT_SYSCALL=3Dy=0A# CONFIG_STRICT_SIGALTS=
TACK_SIZE is not set=0ACONFIG_HAVE_LIVEPATCH=3Dy=0A# CONFIG_LIVEPATCH is =
not set=0A# end of Processor type and features=0A=0ACONFIG_CC_HAS_RETURN_=
THUNK=3Dy=0ACONFIG_SPECULATION_MITIGATIONS=3Dy=0ACONFIG_PAGE_TABLE_ISOLAT=
ION=3Dy=0ACONFIG_RETPOLINE=3Dy=0ACONFIG_RETHUNK=3Dy=0ACONFIG_CPU_UNRET_EN=
TRY=3Dy=0ACONFIG_CPU_IBPB_ENTRY=3Dy=0ACONFIG_CPU_IBRS_ENTRY=3Dy=0ACONFIG_=
ARCH_HAS_ADD_PAGES=3Dy=0ACONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=3Dy=0A=0A=
#=0A# Power management and ACPI options=0A#=0ACONFIG_ARCH_HIBERNATION_HEA=
DER=3Dy=0ACONFIG_SUSPEND=3Dy=0ACONFIG_SUSPEND_FREEZER=3Dy=0A# CONFIG_SUSP=
END_SKIP_SYNC is not set=0ACONFIG_HIBERNATE_CALLBACKS=3Dy=0ACONFIG_HIBERN=
ATION=3Dy=0ACONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy=0ACONFIG_PM_STD_PARTITION=
=3D""=0ACONFIG_PM_SLEEP=3Dy=0ACONFIG_PM_SLEEP_SMP=3Dy=0A# CONFIG_PM_AUTOS=
LEEP is not set=0A# CONFIG_PM_WAKELOCKS is not set=0ACONFIG_PM=3Dy=0ACONF=
IG_PM_DEBUG=3Dy=0ACONFIG_PM_ADVANCED_DEBUG=3Dy=0A# CONFIG_PM_TEST_SUSPEND=
 is not set=0ACONFIG_PM_SLEEP_DEBUG=3Dy=0A# CONFIG_DPM_WATCHDOG is not se=
t=0A# CONFIG_PM_TRACE_RTC is not set=0ACONFIG_PM_CLK=3Dy=0A# CONFIG_WQ_PO=
WER_EFFICIENT_DEFAULT is not set=0ACONFIG_ENERGY_MODEL=3Dy=0ACONFIG_ARCH_=
SUPPORTS_ACPI=3Dy=0ACONFIG_ACPI=3Dy=0ACONFIG_ACPI_LEGACY_TABLES_LOOKUP=3D=
y=0ACONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy=0ACONFIG_ACPI_SYSTEM_POWER_STATES=
_SUPPORT=3Dy=0A# CONFIG_ACPI_DEBUGGER is not set=0ACONFIG_ACPI_SPCR_TABLE=
=3Dy=0A# CONFIG_ACPI_FPDT is not set=0ACONFIG_ACPI_LPIT=3Dy=0ACONFIG_ACPI=
_SLEEP=3Dy=0ACONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy=0A# CONFIG_ACPI_EC_DEB=
UGFS is not set=0A# CONFIG_ACPI_AC is not set=0A# CONFIG_ACPI_BATTERY is =
not set=0ACONFIG_ACPI_BUTTON=3Dm=0A# CONFIG_ACPI_TINY_POWER_BUTTON is not=
 set=0ACONFIG_ACPI_VIDEO=3Dm=0ACONFIG_ACPI_FAN=3Dm=0ACONFIG_ACPI_TAD=3Dm=0A=
CONFIG_ACPI_DOCK=3Dy=0ACONFIG_ACPI_CPU_FREQ_PSS=3Dy=0ACONFIG_ACPI_PROCESS=
OR_CSTATE=3Dy=0ACONFIG_ACPI_PROCESSOR_IDLE=3Dy=0ACONFIG_ACPI_CPPC_LIB=3Dy=
=0ACONFIG_ACPI_PROCESSOR=3Dy=0ACONFIG_ACPI_HOTPLUG_CPU=3Dy=0ACONFIG_ACPI_=
PROCESSOR_AGGREGATOR=3Dm=0ACONFIG_ACPI_THERMAL=3Dy=0ACONFIG_ACPI_CUSTOM_D=
SDT_FILE=3D""=0ACONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy=0ACONFIG_ACPI_TABL=
E_UPGRADE=3Dy=0A# CONFIG_ACPI_DEBUG is not set=0ACONFIG_ACPI_PCI_SLOT=3Dy=
=0ACONFIG_ACPI_CONTAINER=3Dy=0ACONFIG_ACPI_HOTPLUG_MEMORY=3Dy=0ACONFIG_AC=
PI_HOTPLUG_IOAPIC=3Dy=0A# CONFIG_ACPI_SBS is not set=0ACONFIG_ACPI_HED=3D=
y=0A# CONFIG_ACPI_CUSTOM_METHOD is not set=0ACONFIG_ACPI_BGRT=3Dy=0A# CON=
FIG_ACPI_REDUCED_HARDWARE_ONLY is not set=0A# CONFIG_ACPI_NFIT is not set=
=0ACONFIG_ACPI_NUMA=3Dy=0ACONFIG_ACPI_HMAT=3Dy=0ACONFIG_HAVE_ACPI_APEI=3D=
y=0ACONFIG_HAVE_ACPI_APEI_NMI=3Dy=0ACONFIG_ACPI_APEI=3Dy=0ACONFIG_ACPI_AP=
EI_GHES=3Dy=0ACONFIG_ACPI_APEI_PCIEAER=3Dy=0ACONFIG_ACPI_APEI_MEMORY_FAIL=
URE=3Dy=0A# CONFIG_ACPI_APEI_EINJ is not set=0A# CONFIG_ACPI_APEI_ERST_DE=
BUG is not set=0A# CONFIG_ACPI_DPTF is not set=0ACONFIG_ACPI_EXTLOG=3Dy=0A=
# CONFIG_ACPI_CONFIGFS is not set=0A# CONFIG_ACPI_PFRUT is not set=0ACONF=
IG_ACPI_PCC=3Dy=0ACONFIG_PMIC_OPREGION=3Dy=0A# CONFIG_BYTCRC_PMIC_OPREGIO=
N is not set=0A# CONFIG_CHTCRC_PMIC_OPREGION is not set=0ACONFIG_CHT_WC_P=
MIC_OPREGION=3Dy=0ACONFIG_X86_PM_TIMER=3Dy=0ACONFIG_ACPI_PRMT=3Dy=0A=0A#=0A=
# CPU Frequency scaling=0A#=0ACONFIG_CPU_FREQ=3Dy=0ACONFIG_CPU_FREQ_GOV_A=
TTR_SET=3Dy=0ACONFIG_CPU_FREQ_STAT=3Dy=0A# CONFIG_CPU_FREQ_DEFAULT_GOV_PE=
RFORMANCE is not set=0A# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set=
=0A# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set=0ACONFIG_CPU_FREQ_D=
EFAULT_GOV_SCHEDUTIL=3Dy=0ACONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy=0A# CONFIG=
_CPU_FREQ_GOV_POWERSAVE is not set=0A# CONFIG_CPU_FREQ_GOV_USERSPACE is n=
ot set=0A# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set=0A# CONFIG_CPU_FREQ_GO=
V_CONSERVATIVE is not set=0ACONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy=0A=0A#=0A# =
CPU frequency scaling drivers=0A#=0ACONFIG_X86_INTEL_PSTATE=3Dy=0A# CONFI=
G_X86_PCC_CPUFREQ is not set=0A# CONFIG_X86_AMD_PSTATE is not set=0A# CON=
FIG_X86_ACPI_CPUFREQ is not set=0A# CONFIG_X86_SPEEDSTEP_CENTRINO is not =
set=0A# CONFIG_X86_P4_CLOCKMOD is not set=0A=0A#=0A# shared options=0A#=0A=
# end of CPU Frequency scaling=0A=0A#=0A# CPU Idle=0A#=0ACONFIG_CPU_IDLE=3D=
y=0ACONFIG_CPU_IDLE_GOV_LADDER=3Dy=0ACONFIG_CPU_IDLE_GOV_MENU=3Dy=0A# CON=
FIG_CPU_IDLE_GOV_TEO is not set=0A# end of CPU Idle=0A=0ACONFIG_INTEL_IDL=
E=3Dy=0A# end of Power management and ACPI options=0A=0A#=0A# Bus options=
 (PCI etc.)=0A#=0ACONFIG_PCI_DIRECT=3Dy=0ACONFIG_PCI_MMCONFIG=3Dy=0ACONFI=
G_MMCONF_FAM10H=3Dy=0A# CONFIG_PCI_CNB20LE_QUIRK is not set=0A# CONFIG_IS=
A_BUS is not set=0ACONFIG_ISA_DMA_API=3Dy=0ACONFIG_AMD_NB=3Dy=0A# end of =
Bus options (PCI etc.)=0A=0A#=0A# Binary Emulations=0A#=0ACONFIG_IA32_EMU=
LATION=3Dy=0A# CONFIG_X86_X32_ABI is not set=0ACONFIG_COMPAT_32=3Dy=0ACON=
FIG_COMPAT=3Dy=0ACONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy=0A# end of Binary Em=
ulations=0A=0ACONFIG_HAVE_KVM=3Dy=0A# CONFIG_VIRTUALIZATION is not set=0A=
CONFIG_AS_AVX512=3Dy=0ACONFIG_AS_SHA1_NI=3Dy=0ACONFIG_AS_SHA256_NI=3Dy=0A=
CONFIG_AS_TPAUSE=3Dy=0A=0A#=0A# General architecture-dependent options=0A=
#=0ACONFIG_CRASH_CORE=3Dy=0ACONFIG_KEXEC_CORE=3Dy=0ACONFIG_HOTPLUG_SMT=3D=
y=0ACONFIG_GENERIC_ENTRY=3Dy=0ACONFIG_KPROBES=3Dy=0A# CONFIG_JUMP_LABEL i=
s not set=0A# CONFIG_STATIC_CALL_SELFTEST is not set=0ACONFIG_OPTPROBES=3D=
y=0ACONFIG_KPROBES_ON_FTRACE=3Dy=0ACONFIG_UPROBES=3Dy=0ACONFIG_HAVE_EFFIC=
IENT_UNALIGNED_ACCESS=3Dy=0ACONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy=0ACONFIG_KR=
ETPROBES=3Dy=0ACONFIG_KRETPROBE_ON_RETHOOK=3Dy=0ACONFIG_HAVE_IOREMAP_PROT=
=3Dy=0ACONFIG_HAVE_KPROBES=3Dy=0ACONFIG_HAVE_KRETPROBES=3Dy=0ACONFIG_HAVE=
_OPTPROBES=3Dy=0ACONFIG_HAVE_KPROBES_ON_FTRACE=3Dy=0ACONFIG_ARCH_CORRECT_=
STACKTRACE_ON_KRETPROBE=3Dy=0ACONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy=0A=
CONFIG_HAVE_NMI=3Dy=0ACONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy=0ACONFIG_HAVE_ARC=
H_TRACEHOOK=3Dy=0ACONFIG_HAVE_DMA_CONTIGUOUS=3Dy=0ACONFIG_GENERIC_SMP_IDL=
E_THREAD=3Dy=0ACONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy=0ACONFIG_ARCH_HAS_SET_M=
EMORY=3Dy=0ACONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy=0ACONFIG_HAVE_ARCH_THREAD_=
STRUCT_WHITELIST=3Dy=0ACONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy=0ACONFIG=
_ARCH_WANTS_NO_INSTR=3Dy=0ACONFIG_HAVE_ASM_MODVERSIONS=3Dy=0ACONFIG_HAVE_=
REGS_AND_STACK_ACCESS_API=3Dy=0ACONFIG_HAVE_RSEQ=3Dy=0ACONFIG_HAVE_FUNCTI=
ON_ARG_ACCESS_API=3Dy=0ACONFIG_HAVE_HW_BREAKPOINT=3Dy=0ACONFIG_HAVE_MIXED=
_BREAKPOINTS_REGS=3Dy=0ACONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy=0ACONFIG_HAV=
E_PERF_EVENTS_NMI=3Dy=0ACONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy=0ACONFIG=
_HAVE_PERF_REGS=3Dy=0ACONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy=0ACONFIG_HAVE_=
ARCH_JUMP_LABEL=3Dy=0ACONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy=0ACONFIG_M=
MU_GATHER_MERGE_VMAS=3Dy=0ACONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy=0ACONFIG=
_HAVE_ALIGNED_STRUCT_PAGE=3Dy=0ACONFIG_HAVE_CMPXCHG_LOCAL=3Dy=0ACONFIG_HA=
VE_CMPXCHG_DOUBLE=3Dy=0ACONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy=0AC=
ONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy=0ACONFIG_HAVE_ARCH_SECCOMP=3Dy=0ACONFI=
G_HAVE_ARCH_SECCOMP_FILTER=3Dy=0ACONFIG_SECCOMP=3Dy=0ACONFIG_SECCOMP_FILT=
ER=3Dy=0A# CONFIG_SECCOMP_CACHE_DEBUG is not set=0ACONFIG_HAVE_ARCH_STACK=
LEAK=3Dy=0ACONFIG_HAVE_STACKPROTECTOR=3Dy=0ACONFIG_STACKPROTECTOR=3Dy=0AC=
ONFIG_STACKPROTECTOR_STRONG=3Dy=0ACONFIG_ARCH_SUPPORTS_LTO_CLANG=3Dy=0ACO=
NFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy=0ACONFIG_LTO_NONE=3Dy=0ACONFIG_HAVE=
_ARCH_WITHIN_STACK_FRAMES=3Dy=0ACONFIG_HAVE_CONTEXT_TRACKING=3Dy=0ACONFIG=
_HAVE_CONTEXT_TRACKING_OFFSTACK=3Dy=0ACONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=
=3Dy=0ACONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy=0ACONFIG_HAVE_MOVE_PUD=3Dy=0AC=
ONFIG_HAVE_MOVE_PMD=3Dy=0ACONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy=0ACON=
FIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy=0ACONFIG_HAVE_ARCH_HUGE_VMAP=3D=
y=0ACONFIG_HAVE_ARCH_HUGE_VMALLOC=3Dy=0ACONFIG_ARCH_WANT_HUGE_PMD_SHARE=3D=
y=0ACONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy=0ACONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy=0A=
CONFIG_MODULES_USE_ELF_RELA=3Dy=0ACONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy=0A=
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy=0ACONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy=0A=
CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy=0ACONFIG_HAVE_EXIT_THREAD=3Dy=0ACONFIG=
_ARCH_MMAP_RND_BITS=3D28=0ACONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy=0ACO=
NFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8=0ACONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3D=
y=0ACONFIG_PAGE_SIZE_LESS_THAN_64KB=3Dy=0ACONFIG_PAGE_SIZE_LESS_THAN_256K=
B=3Dy=0ACONFIG_HAVE_OBJTOOL=3Dy=0ACONFIG_HAVE_JUMP_LABEL_HACK=3Dy=0ACONFI=
G_HAVE_NOINSTR_HACK=3Dy=0ACONFIG_HAVE_NOINSTR_VALIDATION=3Dy=0ACONFIG_HAV=
E_UACCESS_VALIDATION=3Dy=0ACONFIG_HAVE_STACK_VALIDATION=3Dy=0ACONFIG_HAVE=
_RELIABLE_STACKTRACE=3Dy=0ACONFIG_OLD_SIGSUSPEND3=3Dy=0ACONFIG_COMPAT_OLD=
_SIGACTION=3Dy=0ACONFIG_COMPAT_32BIT_TIME=3Dy=0ACONFIG_ARCH_SUPPORTS_RT=3D=
y=0ACONFIG_HAVE_ARCH_VMAP_STACK=3Dy=0ACONFIG_VMAP_STACK=3Dy=0ACONFIG_HAVE=
_ARCH_RANDOMIZE_KSTACK_OFFSET=3Dy=0ACONFIG_RANDOMIZE_KSTACK_OFFSET=3Dy=0A=
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set=0ACONFIG_ARCH_HAS_STR=
ICT_KERNEL_RWX=3Dy=0ACONFIG_STRICT_KERNEL_RWX=3Dy=0ACONFIG_ARCH_HAS_STRIC=
T_MODULE_RWX=3Dy=0ACONFIG_STRICT_MODULE_RWX=3Dy=0ACONFIG_HAVE_ARCH_PREL32=
_RELOCATIONS=3Dy=0ACONFIG_ARCH_USE_MEMREMAP_PROT=3Dy=0A# CONFIG_LOCK_EVEN=
T_COUNTS is not set=0ACONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy=0ACONFIG_HAVE_STATI=
C_CALL=3Dy=0ACONFIG_HAVE_STATIC_CALL_INLINE=3Dy=0ACONFIG_HAVE_PREEMPT_DYN=
AMIC=3Dy=0ACONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy=0ACONFIG_ARCH_WANT_LD_ORP=
HAN_WARN=3Dy=0ACONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy=0ACONFIG_ARCH_SUP=
PORTS_PAGE_TABLE_CHECK=3Dy=0ACONFIG_ARCH_HAS_ELFCORE_COMPAT=3Dy=0ACONFIG_=
ARCH_HAS_PARANOID_L1D_FLUSH=3Dy=0ACONFIG_DYNAMIC_SIGFRAME=3Dy=0A=0A#=0A# =
GCOV-based kernel profiling=0A#=0A# CONFIG_GCOV_KERNEL is not set=0ACONFI=
G_ARCH_HAS_GCOV_PROFILE_ALL=3Dy=0A# end of GCOV-based kernel profiling=0A=
=0ACONFIG_HAVE_GCC_PLUGINS=3Dy=0A# end of General architecture-dependent =
options=0A=0ACONFIG_RT_MUTEXES=3Dy=0ACONFIG_BASE_SMALL=3D0=0ACONFIG_MODUL=
E_SIG_FORMAT=3Dy=0ACONFIG_MODULES=3Dy=0ACONFIG_MODULE_FORCE_LOAD=3Dy=0ACO=
NFIG_MODULE_UNLOAD=3Dy=0ACONFIG_MODULE_FORCE_UNLOAD=3Dy=0A# CONFIG_MODULE=
_UNLOAD_TAINT_TRACKING is not set=0ACONFIG_MODVERSIONS=3Dy=0ACONFIG_ASM_M=
ODVERSIONS=3Dy=0A# CONFIG_MODULE_SRCVERSION_ALL is not set=0ACONFIG_MODUL=
E_SIG=3Dy=0A# CONFIG_MODULE_SIG_FORCE is not set=0A# CONFIG_MODULE_SIG_AL=
L is not set=0A# CONFIG_MODULE_SIG_SHA1 is not set=0A# CONFIG_MODULE_SIG_=
SHA224 is not set=0ACONFIG_MODULE_SIG_SHA256=3Dy=0A# CONFIG_MODULE_SIG_SH=
A384 is not set=0A# CONFIG_MODULE_SIG_SHA512 is not set=0ACONFIG_MODULE_S=
IG_HASH=3D"sha256"=0ACONFIG_MODULE_COMPRESS_NONE=3Dy=0A# CONFIG_MODULE_CO=
MPRESS_GZIP is not set=0A# CONFIG_MODULE_COMPRESS_XZ is not set=0A# CONFI=
G_MODULE_COMPRESS_ZSTD is not set=0A# CONFIG_MODULE_ALLOW_MISSING_NAMESPA=
CE_IMPORTS is not set=0ACONFIG_MODPROBE_PATH=3D"/sbin/modprobe"=0A# CONFI=
G_TRIM_UNUSED_KSYMS is not set=0ACONFIG_MODULES_TREE_LOOKUP=3Dy=0ACONFIG_=
BLOCK=3Dy=0ACONFIG_BLOCK_LEGACY_AUTOLOAD=3Dy=0ACONFIG_BLK_RQ_ALLOC_TIME=3D=
y=0ACONFIG_BLK_CGROUP_RWSTAT=3Dy=0ACONFIG_BLK_DEV_BSG_COMMON=3Dy=0ACONFIG=
_BLK_DEV_BSGLIB=3Dy=0ACONFIG_BLK_DEV_INTEGRITY=3Dy=0ACONFIG_BLK_DEV_INTEG=
RITY_T10=3Dm=0ACONFIG_BLK_DEV_ZONED=3Dy=0ACONFIG_BLK_DEV_THROTTLING=3Dy=0A=
# CONFIG_BLK_DEV_THROTTLING_LOW is not set=0ACONFIG_BLK_WBT=3Dy=0ACONFIG_=
BLK_WBT_MQ=3Dy=0A# CONFIG_BLK_CGROUP_IOLATENCY is not set=0ACONFIG_BLK_CG=
ROUP_IOCOST=3Dy=0A# CONFIG_BLK_CGROUP_IOPRIO is not set=0ACONFIG_BLK_DEBU=
G_FS=3Dy=0ACONFIG_BLK_DEBUG_FS_ZONED=3Dy=0ACONFIG_BLK_SED_OPAL=3Dy=0A# CO=
NFIG_BLK_INLINE_ENCRYPTION is not set=0A=0A#=0A# Partition Types=0A#=0ACO=
NFIG_PARTITION_ADVANCED=3Dy=0ACONFIG_ACORN_PARTITION=3Dy=0A# CONFIG_ACORN=
_PARTITION_CUMANA is not set=0A# CONFIG_ACORN_PARTITION_EESOX is not set=0A=
CONFIG_ACORN_PARTITION_ICS=3Dy=0A# CONFIG_ACORN_PARTITION_ADFS is not set=
=0A# CONFIG_ACORN_PARTITION_POWERTEC is not set=0ACONFIG_ACORN_PARTITION_=
RISCIX=3Dy=0A# CONFIG_AIX_PARTITION is not set=0ACONFIG_OSF_PARTITION=3Dy=
=0ACONFIG_AMIGA_PARTITION=3Dy=0ACONFIG_ATARI_PARTITION=3Dy=0ACONFIG_MAC_P=
ARTITION=3Dy=0ACONFIG_MSDOS_PARTITION=3Dy=0ACONFIG_BSD_DISKLABEL=3Dy=0ACO=
NFIG_MINIX_SUBPARTITION=3Dy=0ACONFIG_SOLARIS_X86_PARTITION=3Dy=0ACONFIG_U=
NIXWARE_DISKLABEL=3Dy=0ACONFIG_LDM_PARTITION=3Dy=0A# CONFIG_LDM_DEBUG is =
not set=0ACONFIG_SGI_PARTITION=3Dy=0ACONFIG_ULTRIX_PARTITION=3Dy=0ACONFIG=
_SUN_PARTITION=3Dy=0ACONFIG_KARMA_PARTITION=3Dy=0ACONFIG_EFI_PARTITION=3D=
y=0A# CONFIG_SYSV68_PARTITION is not set=0A# CONFIG_CMDLINE_PARTITION is =
not set=0A# end of Partition Types=0A=0ACONFIG_BLOCK_COMPAT=3Dy=0ACONFIG_=
BLK_MQ_PCI=3Dy=0ACONFIG_BLK_PM=3Dy=0A=0A#=0A# IO Schedulers=0A#=0ACONFIG_=
MQ_IOSCHED_DEADLINE=3Dy=0A# CONFIG_MQ_IOSCHED_KYBER is not set=0A# CONFIG=
_IOSCHED_BFQ is not set=0A# end of IO Schedulers=0A=0ACONFIG_PADATA=3Dy=0A=
CONFIG_ASN1=3Dy=0ACONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy=0ACONFIG_MUTEX_SPIN=
_ON_OWNER=3Dy=0ACONFIG_RWSEM_SPIN_ON_OWNER=3Dy=0ACONFIG_LOCK_SPIN_ON_OWNE=
R=3Dy=0ACONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy=0ACONFIG_QUEUED_SPINLOCKS=3D=
y=0ACONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy=0ACONFIG_ARCH_HAS_NON_OVERLAPPING_=
ADDRESS_SPACE=3Dy=0ACONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy=0ACONFI=
G_ARCH_HAS_SYSCALL_WRAPPER=3Dy=0ACONFIG_FREEZER=3Dy=0A=0A#=0A# Executable=
 file formats=0A#=0ACONFIG_BINFMT_ELF=3Dy=0ACONFIG_COMPAT_BINFMT_ELF=3Dy=0A=
CONFIG_ELFCORE=3Dy=0ACONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy=0ACONFIG_BI=
NFMT_SCRIPT=3Dy=0A# CONFIG_BINFMT_MISC is not set=0ACONFIG_COREDUMP=3Dy=0A=
# end of Executable file formats=0A=0A#=0A# Memory Management options=0A#=
=0ACONFIG_ZPOOL=3Dy=0ACONFIG_SWAP=3Dy=0ACONFIG_ZSWAP=3Dy=0A# CONFIG_ZSWAP=
_DEFAULT_ON is not set=0A# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not=
 set=0ACONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=3Dy=0A# CONFIG_ZSWAP_COMPRESSO=
R_DEFAULT_842 is not set=0A# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not s=
et=0A# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set=0A# CONFIG_ZSWAP_=
COMPRESSOR_DEFAULT_ZSTD is not set=0ACONFIG_ZSWAP_COMPRESSOR_DEFAULT=3D"l=
zo"=0ACONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=3Dy=0A# CONFIG_ZSWAP_ZPOOL_DEFAULT_=
Z3FOLD is not set=0A# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set=0ACO=
NFIG_ZSWAP_ZPOOL_DEFAULT=3D"zbud"=0ACONFIG_ZBUD=3Dy=0A# CONFIG_Z3FOLD is =
not set=0A# CONFIG_ZSMALLOC is not set=0A=0A#=0A# SLAB allocator options=0A=
#=0ACONFIG_SLUB=3Dy=0ACONFIG_SLAB_MERGE_DEFAULT=3Dy=0ACONFIG_SLAB_FREELIS=
T_RANDOM=3Dy=0ACONFIG_SLAB_FREELIST_HARDENED=3Dy=0A# CONFIG_SLUB_STATS is=
 not set=0ACONFIG_SLUB_CPU_PARTIAL=3Dy=0A# end of SLAB allocator options=0A=
=0ACONFIG_SHUFFLE_PAGE_ALLOCATOR=3Dy=0A# CONFIG_COMPAT_BRK is not set=0AC=
ONFIG_SPARSEMEM=3Dy=0ACONFIG_SPARSEMEM_EXTREME=3Dy=0ACONFIG_SPARSEMEM_VME=
MMAP_ENABLE=3Dy=0ACONFIG_SPARSEMEM_VMEMMAP=3Dy=0ACONFIG_HAVE_FAST_GUP=3Dy=
=0ACONFIG_NUMA_KEEP_MEMINFO=3Dy=0ACONFIG_MEMORY_ISOLATION=3Dy=0ACONFIG_EX=
CLUSIVE_SYSTEM_RAM=3Dy=0ACONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy=0ACONFIG_ARCH_=
ENABLE_MEMORY_HOTPLUG=3Dy=0ACONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy=0ACON=
FIG_MEMORY_HOTPLUG=3Dy=0A# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not se=
t=0ACONFIG_MEMORY_HOTREMOVE=3Dy=0ACONFIG_MHP_MEMMAP_ON_MEMORY=3Dy=0ACONFI=
G_SPLIT_PTLOCK_CPUS=3D4=0ACONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy=0ACONFI=
G_COMPACTION=3Dy=0A# CONFIG_PAGE_REPORTING is not set=0ACONFIG_MIGRATION=3D=
y=0ACONFIG_DEVICE_MIGRATION=3Dy=0ACONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3D=
y=0ACONFIG_CONTIG_ALLOC=3Dy=0ACONFIG_PHYS_ADDR_T_64BIT=3Dy=0ACONFIG_VIRT_=
TO_BUS=3Dy=0ACONFIG_MMU_NOTIFIER=3Dy=0ACONFIG_KSM=3Dy=0ACONFIG_DEFAULT_MM=
AP_MIN_ADDR=3D65536=0ACONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy=0ACONFIG_ME=
MORY_FAILURE=3Dy=0A# CONFIG_HWPOISON_INJECT is not set=0ACONFIG_ARCH_WANT=
_GENERAL_HUGETLB=3Dy=0ACONFIG_ARCH_WANTS_THP_SWAP=3Dy=0ACONFIG_NEED_PER_C=
PU_EMBED_FIRST_CHUNK=3Dy=0ACONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy=0ACON=
FIG_USE_PERCPU_NUMA_NODE_ID=3Dy=0ACONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy=0ACO=
NFIG_FRONTSWAP=3Dy=0A# CONFIG_CMA is not set=0ACONFIG_MEM_SOFT_DIRTY=3Dy=0A=
CONFIG_GENERIC_EARLY_IOREMAP=3Dy=0ACONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy=0A=
# CONFIG_IDLE_PAGE_TRACKING is not set=0ACONFIG_ARCH_HAS_CACHE_LINE_SIZE=3D=
y=0ACONFIG_ARCH_HAS_CURRENT_STACK_POINTER=3Dy=0ACONFIG_ARCH_HAS_VM_GET_PA=
GE_PROT=3Dy=0ACONFIG_ARCH_HAS_PTE_DEVMAP=3Dy=0ACONFIG_ARCH_HAS_ZONE_DMA_S=
ET=3Dy=0ACONFIG_ZONE_DMA=3Dy=0ACONFIG_ZONE_DMA32=3Dy=0ACONFIG_ZONE_DEVICE=
=3Dy=0A# CONFIG_DEVICE_PRIVATE is not set=0ACONFIG_VMAP_PFN=3Dy=0ACONFIG_=
ARCH_USES_HIGH_VMA_FLAGS=3Dy=0ACONFIG_ARCH_HAS_PKEYS=3Dy=0ACONFIG_VM_EVEN=
T_COUNTERS=3Dy=0A# CONFIG_PERCPU_STATS is not set=0A# CONFIG_GUP_TEST is =
not set=0ACONFIG_ARCH_HAS_PTE_SPECIAL=3Dy=0ACONFIG_SECRETMEM=3Dy=0A# CONF=
IG_ANON_VMA_NAME is not set=0ACONFIG_USERFAULTFD=3Dy=0ACONFIG_HAVE_ARCH_U=
SERFAULTFD_WP=3Dy=0ACONFIG_HAVE_ARCH_USERFAULTFD_MINOR=3Dy=0ACONFIG_PTE_M=
ARKER=3Dy=0ACONFIG_PTE_MARKER_UFFD_WP=3Dy=0A=0A#=0A# Data Access Monitori=
ng=0A#=0A# CONFIG_DAMON is not set=0A# end of Data Access Monitoring=0A# =
end of Memory Management options=0A=0ACONFIG_NET=3Dy=0ACONFIG_NET_INGRESS=
=3Dy=0ACONFIG_NET_EGRESS=3Dy=0ACONFIG_SKB_EXTENSIONS=3Dy=0A=0A#=0A# Netwo=
rking options=0A#=0ACONFIG_PACKET=3Dy=0A# CONFIG_PACKET_DIAG is not set=0A=
CONFIG_UNIX=3Dy=0ACONFIG_UNIX_SCM=3Dy=0ACONFIG_AF_UNIX_OOB=3Dy=0A# CONFIG=
_UNIX_DIAG is not set=0A# CONFIG_TLS is not set=0ACONFIG_XFRM=3Dy=0A# CON=
FIG_XFRM_USER is not set=0A# CONFIG_XFRM_INTERFACE is not set=0ACONFIG_XF=
RM_SUB_POLICY=3Dy=0ACONFIG_XFRM_MIGRATE=3Dy=0ACONFIG_XFRM_STATISTICS=3Dy=0A=
# CONFIG_NET_KEY is not set=0ACONFIG_XDP_SOCKETS=3Dy=0A# CONFIG_XDP_SOCKE=
TS_DIAG is not set=0ACONFIG_INET=3Dy=0ACONFIG_IP_MULTICAST=3Dy=0ACONFIG_I=
P_ADVANCED_ROUTER=3Dy=0ACONFIG_IP_FIB_TRIE_STATS=3Dy=0ACONFIG_IP_MULTIPLE=
_TABLES=3Dy=0ACONFIG_IP_ROUTE_MULTIPATH=3Dy=0ACONFIG_IP_ROUTE_VERBOSE=3Dy=
=0A# CONFIG_IP_PNP is not set=0ACONFIG_NET_IPIP=3Dy=0A# CONFIG_NET_IPGRE_=
DEMUX is not set=0ACONFIG_NET_IP_TUNNEL=3Dy=0ACONFIG_IP_MROUTE_COMMON=3Dy=
=0ACONFIG_IP_MROUTE=3Dy=0ACONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy=0ACONFIG_I=
P_PIMSM_V1=3Dy=0ACONFIG_IP_PIMSM_V2=3Dy=0ACONFIG_SYN_COOKIES=3Dy=0A# CONF=
IG_NET_IPVTI is not set=0A# CONFIG_NET_FOU is not set=0A# CONFIG_NET_FOU_=
IP_TUNNELS is not set=0A# CONFIG_INET_AH is not set=0A# CONFIG_INET_ESP i=
s not set=0A# CONFIG_INET_IPCOMP is not set=0ACONFIG_INET_TUNNEL=3Dy=0A# =
CONFIG_INET_DIAG is not set=0ACONFIG_TCP_CONG_ADVANCED=3Dy=0A# CONFIG_TCP=
_CONG_BIC is not set=0ACONFIG_TCP_CONG_CUBIC=3Dy=0A# CONFIG_TCP_CONG_WEST=
WOOD is not set=0A# CONFIG_TCP_CONG_HTCP is not set=0A# CONFIG_TCP_CONG_H=
STCP is not set=0A# CONFIG_TCP_CONG_HYBLA is not set=0A# CONFIG_TCP_CONG_=
VEGAS is not set=0A# CONFIG_TCP_CONG_NV is not set=0A# CONFIG_TCP_CONG_SC=
ALABLE is not set=0A# CONFIG_TCP_CONG_LP is not set=0A# CONFIG_TCP_CONG_V=
ENO is not set=0A# CONFIG_TCP_CONG_YEAH is not set=0A# CONFIG_TCP_CONG_IL=
LINOIS is not set=0A# CONFIG_TCP_CONG_DCTCP is not set=0A# CONFIG_TCP_CON=
G_CDG is not set=0A# CONFIG_TCP_CONG_BBR is not set=0ACONFIG_DEFAULT_CUBI=
C=3Dy=0A# CONFIG_DEFAULT_RENO is not set=0ACONFIG_DEFAULT_TCP_CONG=3D"cub=
ic"=0ACONFIG_TCP_MD5SIG=3Dy=0ACONFIG_IPV6=3Dy=0ACONFIG_IPV6_ROUTER_PREF=3D=
y=0ACONFIG_IPV6_ROUTE_INFO=3Dy=0ACONFIG_IPV6_OPTIMISTIC_DAD=3Dy=0A# CONFI=
G_INET6_AH is not set=0A# CONFIG_INET6_ESP is not set=0A# CONFIG_INET6_IP=
COMP is not set=0ACONFIG_IPV6_MIP6=3Dy=0A# CONFIG_IPV6_ILA is not set=0A#=
 CONFIG_IPV6_VTI is not set=0A# CONFIG_IPV6_SIT is not set=0A# CONFIG_IPV=
6_TUNNEL is not set=0ACONFIG_IPV6_MULTIPLE_TABLES=3Dy=0ACONFIG_IPV6_SUBTR=
EES=3Dy=0ACONFIG_IPV6_MROUTE=3Dy=0ACONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy=
=0ACONFIG_IPV6_PIMSM_V2=3Dy=0ACONFIG_IPV6_SEG6_LWTUNNEL=3Dy=0ACONFIG_IPV6=
_SEG6_HMAC=3Dy=0ACONFIG_IPV6_SEG6_BPF=3Dy=0A# CONFIG_IPV6_RPL_LWTUNNEL is=
 not set=0A# CONFIG_IPV6_IOAM6_LWTUNNEL is not set=0ACONFIG_NETLABEL=3Dy=0A=
# CONFIG_MPTCP is not set=0ACONFIG_NETWORK_SECMARK=3Dy=0ACONFIG_NET_PTP_C=
LASSIFY=3Dy=0A# CONFIG_NETWORK_PHY_TIMESTAMPING is not set=0ACONFIG_NETFI=
LTER=3Dy=0ACONFIG_NETFILTER_ADVANCED=3Dy=0A=0A#=0A# Core Netfilter Config=
uration=0A#=0ACONFIG_NETFILTER_INGRESS=3Dy=0ACONFIG_NETFILTER_EGRESS=3Dy=0A=
CONFIG_NETFILTER_SKIP_EGRESS=3Dy=0A# CONFIG_NETFILTER_NETLINK_ACCT is not=
 set=0A# CONFIG_NETFILTER_NETLINK_QUEUE is not set=0A# CONFIG_NETFILTER_N=
ETLINK_LOG is not set=0A# CONFIG_NETFILTER_NETLINK_OSF is not set=0A# CON=
FIG_NF_CONNTRACK is not set=0A# CONFIG_NF_LOG_SYSLOG is not set=0A# CONFI=
G_NF_TABLES is not set=0ACONFIG_NETFILTER_XTABLES=3Dm=0ACONFIG_NETFILTER_=
XTABLES_COMPAT=3Dy=0A=0A#=0A# Xtables combined modules=0A#=0A# CONFIG_NET=
FILTER_XT_MARK is not set=0A=0A#=0A# Xtables targets=0A#=0A# CONFIG_NETFI=
LTER_XT_TARGET_AUDIT is not set=0A# CONFIG_NETFILTER_XT_TARGET_CLASSIFY i=
s not set=0A# CONFIG_NETFILTER_XT_TARGET_HMARK is not set=0A# CONFIG_NETF=
ILTER_XT_TARGET_IDLETIMER is not set=0A# CONFIG_NETFILTER_XT_TARGET_LED i=
s not set=0A# CONFIG_NETFILTER_XT_TARGET_LOG is not set=0A# CONFIG_NETFIL=
TER_XT_TARGET_MARK is not set=0A# CONFIG_NETFILTER_XT_TARGET_NFLOG is not=
 set=0A# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set=0A# CONFIG_NETFILT=
ER_XT_TARGET_RATEEST is not set=0A# CONFIG_NETFILTER_XT_TARGET_TEE is not=
 set=0A# CONFIG_NETFILTER_XT_TARGET_SECMARK is not set=0A# CONFIG_NETFILT=
ER_XT_TARGET_TCPMSS is not set=0A=0A#=0A# Xtables matches=0A#=0A# CONFIG_=
NETFILTER_XT_MATCH_ADDRTYPE is not set=0A# CONFIG_NETFILTER_XT_MATCH_BPF =
is not set=0A# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set=0A# CONFIG_NET=
FILTER_XT_MATCH_COMMENT is not set=0A# CONFIG_NETFILTER_XT_MATCH_CPU is n=
ot set=0A# CONFIG_NETFILTER_XT_MATCH_DCCP is not set=0A# CONFIG_NETFILTER=
_XT_MATCH_DEVGROUP is not set=0A# CONFIG_NETFILTER_XT_MATCH_DSCP is not s=
et=0A# CONFIG_NETFILTER_XT_MATCH_ECN is not set=0A# CONFIG_NETFILTER_XT_M=
ATCH_ESP is not set=0A# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set=0A=
# CONFIG_NETFILTER_XT_MATCH_HL is not set=0A# CONFIG_NETFILTER_XT_MATCH_I=
PCOMP is not set=0A# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set=0A# CON=
FIG_NETFILTER_XT_MATCH_L2TP is not set=0A# CONFIG_NETFILTER_XT_MATCH_LENG=
TH is not set=0A# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set=0A# CONFIG_N=
ETFILTER_XT_MATCH_MAC is not set=0A# CONFIG_NETFILTER_XT_MATCH_MARK is no=
t set=0A# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set=0A# CONFIG_NETFI=
LTER_XT_MATCH_NFACCT is not set=0A# CONFIG_NETFILTER_XT_MATCH_OSF is not =
set=0A# CONFIG_NETFILTER_XT_MATCH_OWNER is not set=0A# CONFIG_NETFILTER_X=
T_MATCH_POLICY is not set=0A# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not se=
t=0A# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set=0A# CONFIG_NETFILTER_XT_=
MATCH_RATEEST is not set=0A# CONFIG_NETFILTER_XT_MATCH_REALM is not set=0A=
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set=0A# CONFIG_NETFILTER_XT_MAT=
CH_SCTP is not set=0A# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set=0A# CO=
NFIG_NETFILTER_XT_MATCH_STATISTIC is not set=0A# CONFIG_NETFILTER_XT_MATC=
H_STRING is not set=0A# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set=0A# C=
ONFIG_NETFILTER_XT_MATCH_TIME is not set=0A# CONFIG_NETFILTER_XT_MATCH_U3=
2 is not set=0A# end of Core Netfilter Configuration=0A=0A# CONFIG_IP_SET=
 is not set=0A# CONFIG_IP_VS is not set=0A=0A#=0A# IP: Netfilter Configur=
ation=0A#=0A# CONFIG_NF_SOCKET_IPV4 is not set=0A# CONFIG_NF_TPROXY_IPV4 =
is not set=0A# CONFIG_NF_DUP_IPV4 is not set=0A# CONFIG_NF_LOG_ARP is not=
 set=0A# CONFIG_NF_LOG_IPV4 is not set=0A# CONFIG_NF_REJECT_IPV4 is not s=
et=0ACONFIG_IP_NF_IPTABLES=3Dm=0A# CONFIG_IP_NF_MATCH_AH is not set=0A# C=
ONFIG_IP_NF_MATCH_ECN is not set=0A# CONFIG_IP_NF_MATCH_TTL is not set=0A=
# CONFIG_IP_NF_FILTER is not set=0A# CONFIG_IP_NF_MANGLE is not set=0A# C=
ONFIG_IP_NF_RAW is not set=0A# CONFIG_IP_NF_SECURITY is not set=0A# CONFI=
G_IP_NF_ARPTABLES is not set=0A# end of IP: Netfilter Configuration=0A=0A=
#=0A# IPv6: Netfilter Configuration=0A#=0A# CONFIG_NF_SOCKET_IPV6 is not =
set=0A# CONFIG_NF_TPROXY_IPV6 is not set=0A# CONFIG_NF_DUP_IPV6 is not se=
t=0A# CONFIG_NF_REJECT_IPV6 is not set=0A# CONFIG_NF_LOG_IPV6 is not set=0A=
# CONFIG_IP6_NF_IPTABLES is not set=0A# end of IPv6: Netfilter Configurat=
ion=0A=0A# CONFIG_BPFILTER is not set=0A# CONFIG_IP_DCCP is not set=0A# C=
ONFIG_IP_SCTP is not set=0A# CONFIG_RDS is not set=0A# CONFIG_TIPC is not=
 set=0A# CONFIG_ATM is not set=0A# CONFIG_L2TP is not set=0A# CONFIG_BRID=
GE is not set=0A# CONFIG_NET_DSA is not set=0A# CONFIG_VLAN_8021Q is not =
set=0A# CONFIG_DECNET is not set=0A# CONFIG_LLC2 is not set=0A# CONFIG_AT=
ALK is not set=0A# CONFIG_X25 is not set=0A# CONFIG_LAPB is not set=0A# C=
ONFIG_PHONET is not set=0A# CONFIG_6LOWPAN is not set=0A# CONFIG_IEEE8021=
54 is not set=0ACONFIG_NET_SCHED=3Dy=0A=0A#=0A# Queueing/Scheduling=0A#=0A=
# CONFIG_NET_SCH_CBQ is not set=0A# CONFIG_NET_SCH_HTB is not set=0A# CON=
FIG_NET_SCH_HFSC is not set=0A# CONFIG_NET_SCH_PRIO is not set=0A# CONFIG=
_NET_SCH_MULTIQ is not set=0A# CONFIG_NET_SCH_RED is not set=0A# CONFIG_N=
ET_SCH_SFB is not set=0A# CONFIG_NET_SCH_SFQ is not set=0A# CONFIG_NET_SC=
H_TEQL is not set=0A# CONFIG_NET_SCH_TBF is not set=0A# CONFIG_NET_SCH_CB=
S is not set=0A# CONFIG_NET_SCH_ETF is not set=0A# CONFIG_NET_SCH_TAPRIO =
is not set=0A# CONFIG_NET_SCH_GRED is not set=0A# CONFIG_NET_SCH_DSMARK i=
s not set=0A# CONFIG_NET_SCH_NETEM is not set=0A# CONFIG_NET_SCH_DRR is n=
ot set=0A# CONFIG_NET_SCH_MQPRIO is not set=0A# CONFIG_NET_SCH_SKBPRIO is=
 not set=0A# CONFIG_NET_SCH_CHOKE is not set=0A# CONFIG_NET_SCH_QFQ is no=
t set=0A# CONFIG_NET_SCH_CODEL is not set=0A# CONFIG_NET_SCH_FQ_CODEL is =
not set=0A# CONFIG_NET_SCH_CAKE is not set=0A# CONFIG_NET_SCH_FQ is not s=
et=0A# CONFIG_NET_SCH_HHF is not set=0A# CONFIG_NET_SCH_PIE is not set=0A=
# CONFIG_NET_SCH_INGRESS is not set=0A# CONFIG_NET_SCH_PLUG is not set=0A=
# CONFIG_NET_SCH_ETS is not set=0A# CONFIG_NET_SCH_DEFAULT is not set=0A=0A=
#=0A# Classification=0A#=0ACONFIG_NET_CLS=3Dy=0A# CONFIG_NET_CLS_BASIC is=
 not set=0A# CONFIG_NET_CLS_TCINDEX is not set=0A# CONFIG_NET_CLS_ROUTE4 =
is not set=0A# CONFIG_NET_CLS_FW is not set=0A# CONFIG_NET_CLS_U32 is not=
 set=0A# CONFIG_NET_CLS_RSVP is not set=0A# CONFIG_NET_CLS_RSVP6 is not s=
et=0A# CONFIG_NET_CLS_FLOW is not set=0A# CONFIG_NET_CLS_CGROUP is not se=
t=0A# CONFIG_NET_CLS_BPF is not set=0A# CONFIG_NET_CLS_FLOWER is not set=0A=
# CONFIG_NET_CLS_MATCHALL is not set=0ACONFIG_NET_EMATCH=3Dy=0ACONFIG_NET=
_EMATCH_STACK=3D32=0A# CONFIG_NET_EMATCH_CMP is not set=0A# CONFIG_NET_EM=
ATCH_NBYTE is not set=0A# CONFIG_NET_EMATCH_U32 is not set=0A# CONFIG_NET=
_EMATCH_META is not set=0A# CONFIG_NET_EMATCH_TEXT is not set=0A# CONFIG_=
NET_EMATCH_IPT is not set=0ACONFIG_NET_CLS_ACT=3Dy=0A# CONFIG_NET_ACT_POL=
ICE is not set=0A# CONFIG_NET_ACT_GACT is not set=0A# CONFIG_NET_ACT_MIRR=
ED is not set=0A# CONFIG_NET_ACT_SAMPLE is not set=0A# CONFIG_NET_ACT_IPT=
 is not set=0A# CONFIG_NET_ACT_NAT is not set=0A# CONFIG_NET_ACT_PEDIT is=
 not set=0A# CONFIG_NET_ACT_SIMP is not set=0A# CONFIG_NET_ACT_SKBEDIT is=
 not set=0A# CONFIG_NET_ACT_CSUM is not set=0A# CONFIG_NET_ACT_MPLS is no=
t set=0A# CONFIG_NET_ACT_VLAN is not set=0A# CONFIG_NET_ACT_BPF is not se=
t=0A# CONFIG_NET_ACT_SKBMOD is not set=0A# CONFIG_NET_ACT_IFE is not set=0A=
# CONFIG_NET_ACT_TUNNEL_KEY is not set=0A# CONFIG_NET_ACT_GATE is not set=
=0A# CONFIG_NET_TC_SKB_EXT is not set=0ACONFIG_NET_SCH_FIFO=3Dy=0ACONFIG_=
DCB=3Dy=0ACONFIG_DNS_RESOLVER=3Dy=0A# CONFIG_BATMAN_ADV is not set=0A# CO=
NFIG_OPENVSWITCH is not set=0A# CONFIG_VSOCKETS is not set=0A# CONFIG_NET=
LINK_DIAG is not set=0ACONFIG_MPLS=3Dy=0ACONFIG_NET_MPLS_GSO=3Dy=0A# CONF=
IG_MPLS_ROUTING is not set=0A# CONFIG_NET_NSH is not set=0A# CONFIG_HSR i=
s not set=0ACONFIG_NET_SWITCHDEV=3Dy=0ACONFIG_NET_L3_MASTER_DEV=3Dy=0A# C=
ONFIG_QRTR is not set=0A# CONFIG_NET_NCSI is not set=0ACONFIG_PCPU_DEV_RE=
FCNT=3Dy=0ACONFIG_RPS=3Dy=0ACONFIG_RFS_ACCEL=3Dy=0ACONFIG_SOCK_RX_QUEUE_M=
APPING=3Dy=0ACONFIG_XPS=3Dy=0ACONFIG_CGROUP_NET_PRIO=3Dy=0ACONFIG_CGROUP_=
NET_CLASSID=3Dy=0ACONFIG_BQL=3Dy=0ACONFIG_BPF_STREAM_PARSER=3Dy=0ACONFIG_=
NET_FLOW_LIMIT=3Dy=0A=0A#=0A# Network testing=0A#=0A# CONFIG_NET_PKTGEN i=
s not set=0A# CONFIG_NET_DROP_MONITOR is not set=0A# end of Network testi=
ng=0A# end of Networking options=0A=0ACONFIG_HAMRADIO=3Dy=0A=0A#=0A# Pack=
et Radio protocols=0A#=0A# CONFIG_AX25 is not set=0A# CONFIG_CAN is not s=
et=0ACONFIG_BT=3Dm=0ACONFIG_BT_BREDR=3Dy=0A# CONFIG_BT_RFCOMM is not set=0A=
CONFIG_BT_BNEP=3Dm=0ACONFIG_BT_BNEP_MC_FILTER=3Dy=0ACONFIG_BT_BNEP_PROTO_=
FILTER=3Dy=0A# CONFIG_BT_CMTP is not set=0A# CONFIG_BT_HIDP is not set=0A=
CONFIG_BT_HS=3Dy=0ACONFIG_BT_LE=3Dy=0ACONFIG_BT_LEDS=3Dy=0A# CONFIG_BT_MS=
FTEXT is not set=0A# CONFIG_BT_AOSPEXT is not set=0ACONFIG_BT_DEBUGFS=3Dy=
=0A# CONFIG_BT_SELFTEST is not set=0A=0A#=0A# Bluetooth device drivers=0A=
#=0ACONFIG_BT_INTEL=3Dm=0ACONFIG_BT_BCM=3Dm=0ACONFIG_BT_RTL=3Dm=0ACONFIG_=
BT_HCIBTUSB=3Dm=0ACONFIG_BT_HCIBTUSB_AUTOSUSPEND=3Dy=0ACONFIG_BT_HCIBTUSB=
_BCM=3Dy=0A# CONFIG_BT_HCIBTUSB_MTK is not set=0ACONFIG_BT_HCIBTUSB_RTL=3D=
y=0A# CONFIG_BT_HCIBTSDIO is not set=0A# CONFIG_BT_HCIUART is not set=0A#=
 CONFIG_BT_HCIBCM203X is not set=0A# CONFIG_BT_HCIBPA10X is not set=0A# C=
ONFIG_BT_HCIBFUSB is not set=0A# CONFIG_BT_HCIVHCI is not set=0A# CONFIG_=
BT_MRVL is not set=0A# CONFIG_BT_ATH3K is not set=0A# CONFIG_BT_MTKSDIO i=
s not set=0A# CONFIG_BT_MTKUART is not set=0A# end of Bluetooth device dr=
ivers=0A=0A# CONFIG_AF_RXRPC is not set=0A# CONFIG_AF_KCM is not set=0ACO=
NFIG_STREAM_PARSER=3Dy=0A# CONFIG_MCTP is not set=0ACONFIG_FIB_RULES=3Dy=0A=
CONFIG_WIRELESS=3Dy=0ACONFIG_CFG80211=3Dm=0A# CONFIG_NL80211_TESTMODE is =
not set=0A# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set=0A# CONFIG_CFG8=
0211_CERTIFICATION_ONUS is not set=0ACONFIG_CFG80211_REQUIRE_SIGNED_REGDB=
=3Dy=0ACONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy=0ACONFIG_CFG80211_DEFAUL=
T_PS=3Dy=0A# CONFIG_CFG80211_DEBUGFS is not set=0ACONFIG_CFG80211_CRDA_SU=
PPORT=3Dy=0A# CONFIG_CFG80211_WEXT is not set=0ACONFIG_MAC80211=3Dm=0ACON=
FIG_MAC80211_HAS_RC=3Dy=0ACONFIG_MAC80211_RC_MINSTREL=3Dy=0ACONFIG_MAC802=
11_RC_DEFAULT_MINSTREL=3Dy=0ACONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"=0A=
# CONFIG_MAC80211_MESH is not set=0ACONFIG_MAC80211_LEDS=3Dy=0A# CONFIG_M=
AC80211_DEBUGFS is not set=0A# CONFIG_MAC80211_MESSAGE_TRACING is not set=
=0A# CONFIG_MAC80211_DEBUG_MENU is not set=0ACONFIG_MAC80211_STA_HASH_MAX=
_SIZE=3D0=0ACONFIG_RFKILL=3Dm=0ACONFIG_RFKILL_LEDS=3Dy=0ACONFIG_RFKILL_IN=
PUT=3Dy=0A# CONFIG_RFKILL_GPIO is not set=0A# CONFIG_NET_9P is not set=0A=
# CONFIG_CAIF is not set=0A# CONFIG_CEPH_LIB is not set=0A# CONFIG_NFC is=
 not set=0A# CONFIG_PSAMPLE is not set=0A# CONFIG_NET_IFE is not set=0ACO=
NFIG_LWTUNNEL=3Dy=0ACONFIG_LWTUNNEL_BPF=3Dy=0ACONFIG_DST_CACHE=3Dy=0ACONF=
IG_GRO_CELLS=3Dy=0ACONFIG_NET_SELFTESTS=3Dm=0ACONFIG_NET_SOCK_MSG=3Dy=0AC=
ONFIG_PAGE_POOL=3Dy=0A# CONFIG_PAGE_POOL_STATS is not set=0A# CONFIG_FAIL=
OVER is not set=0ACONFIG_ETHTOOL_NETLINK=3Dy=0A=0A#=0A# Device Drivers=0A=
#=0ACONFIG_HAVE_EISA=3Dy=0A# CONFIG_EISA is not set=0ACONFIG_HAVE_PCI=3Dy=
=0ACONFIG_PCI=3Dy=0ACONFIG_PCI_DOMAINS=3Dy=0ACONFIG_PCIEPORTBUS=3Dy=0ACON=
FIG_HOTPLUG_PCI_PCIE=3Dy=0ACONFIG_PCIEAER=3Dy=0A# CONFIG_PCIEAER_INJECT i=
s not set=0A# CONFIG_PCIE_ECRC is not set=0ACONFIG_PCIEASPM=3Dy=0ACONFIG_=
PCIEASPM_DEFAULT=3Dy=0A# CONFIG_PCIEASPM_POWERSAVE is not set=0A# CONFIG_=
PCIEASPM_POWER_SUPERSAVE is not set=0A# CONFIG_PCIEASPM_PERFORMANCE is no=
t set=0ACONFIG_PCIE_PME=3Dy=0ACONFIG_PCIE_DPC=3Dy=0ACONFIG_PCIE_PTM=3Dy=0A=
# CONFIG_PCIE_EDR is not set=0ACONFIG_PCI_MSI=3Dy=0ACONFIG_PCI_MSI_IRQ_DO=
MAIN=3Dy=0ACONFIG_PCI_QUIRKS=3Dy=0A# CONFIG_PCI_DEBUG is not set=0ACONFIG=
_PCI_REALLOC_ENABLE_AUTO=3Dy=0A# CONFIG_PCI_STUB is not set=0A# CONFIG_PC=
I_PF_STUB is not set=0ACONFIG_PCI_ATS=3Dy=0ACONFIG_PCI_LOCKLESS_CONFIG=3D=
y=0ACONFIG_PCI_IOV=3Dy=0ACONFIG_PCI_PRI=3Dy=0ACONFIG_PCI_PASID=3Dy=0A# CO=
NFIG_PCI_P2PDMA is not set=0ACONFIG_PCI_LABEL=3Dy=0A# CONFIG_PCIE_BUS_TUN=
E_OFF is not set=0ACONFIG_PCIE_BUS_DEFAULT=3Dy=0A# CONFIG_PCIE_BUS_SAFE i=
s not set=0A# CONFIG_PCIE_BUS_PERFORMANCE is not set=0A# CONFIG_PCIE_BUS_=
PEER2PEER is not set=0ACONFIG_VGA_ARB=3Dy=0ACONFIG_VGA_ARB_MAX_GPUS=3D16=0A=
CONFIG_HOTPLUG_PCI=3Dy=0ACONFIG_HOTPLUG_PCI_ACPI=3Dy=0A# CONFIG_HOTPLUG_P=
CI_ACPI_IBM is not set=0ACONFIG_HOTPLUG_PCI_CPCI=3Dy=0A# CONFIG_HOTPLUG_P=
CI_CPCI_ZT5550 is not set=0A# CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set=0A=
CONFIG_HOTPLUG_PCI_SHPC=3Dy=0A=0A#=0A# PCI controller drivers=0A#=0A# CON=
FIG_VMD is not set=0A=0A#=0A# DesignWare PCI Core Support=0A#=0A# CONFIG_=
PCIE_DW_PLAT_HOST is not set=0A# CONFIG_PCI_MESON is not set=0A# end of D=
esignWare PCI Core Support=0A=0A#=0A# Mobiveil PCIe Core Support=0A#=0A# =
end of Mobiveil PCIe Core Support=0A=0A#=0A# Cadence PCIe controllers sup=
port=0A#=0A# end of Cadence PCIe controllers support=0A# end of PCI contr=
oller drivers=0A=0A#=0A# PCI Endpoint=0A#=0A# CONFIG_PCI_ENDPOINT is not =
set=0A# end of PCI Endpoint=0A=0A#=0A# PCI switch controller drivers=0A#=0A=
# CONFIG_PCI_SW_SWITCHTEC is not set=0A# end of PCI switch controller dri=
vers=0A=0A# CONFIG_CXL_BUS is not set=0A# CONFIG_PCCARD is not set=0A# CO=
NFIG_RAPIDIO is not set=0A=0A#=0A# Generic Driver Options=0A#=0ACONFIG_AU=
XILIARY_BUS=3Dy=0A# CONFIG_UEVENT_HELPER is not set=0ACONFIG_DEVTMPFS=3Dy=
=0A# CONFIG_DEVTMPFS_MOUNT is not set=0A# CONFIG_DEVTMPFS_SAFE is not set=
=0A# CONFIG_STANDALONE is not set=0A# CONFIG_PREVENT_FIRMWARE_BUILD is no=
t set=0A=0A#=0A# Firmware loader=0A#=0ACONFIG_FW_LOADER=3Dy=0ACONFIG_FW_L=
OADER_PAGED_BUF=3Dy=0ACONFIG_FW_LOADER_SYSFS=3Dy=0ACONFIG_EXTRA_FIRMWARE=3D=
""=0ACONFIG_FW_LOADER_USER_HELPER=3Dy=0A# CONFIG_FW_LOADER_USER_HELPER_FA=
LLBACK is not set=0A# CONFIG_FW_LOADER_COMPRESS is not set=0ACONFIG_FW_CA=
CHE=3Dy=0A# CONFIG_FW_UPLOAD is not set=0A# end of Firmware loader=0A=0AC=
ONFIG_WANT_DEV_COREDUMP=3Dy=0ACONFIG_ALLOW_DEV_COREDUMP=3Dy=0ACONFIG_DEV_=
COREDUMP=3Dy=0A# CONFIG_DEBUG_DRIVER is not set=0A# CONFIG_DEBUG_DEVRES i=
s not set=0A# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set=0ACONFIG_HMEM_RE=
PORTING=3Dy=0A# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set=0ACONFIG_GENERI=
C_CPU_AUTOPROBE=3Dy=0ACONFIG_GENERIC_CPU_VULNERABILITIES=3Dy=0ACONFIG_REG=
MAP=3Dy=0ACONFIG_REGMAP_I2C=3Dy=0ACONFIG_REGMAP_SPI=3Dm=0ACONFIG_REGMAP_M=
MIO=3Dy=0ACONFIG_REGMAP_IRQ=3Dy=0ACONFIG_DMA_SHARED_BUFFER=3Dy=0A# CONFIG=
_DMA_FENCE_TRACE is not set=0A# end of Generic Driver Options=0A=0A#=0A# =
Bus devices=0A#=0A# CONFIG_MHI_BUS is not set=0A# CONFIG_MHI_BUS_EP is no=
t set=0A# end of Bus devices=0A=0ACONFIG_CONNECTOR=3Dy=0ACONFIG_PROC_EVEN=
TS=3Dy=0A=0A#=0A# Firmware Drivers=0A#=0A=0A#=0A# ARM System Control and =
Management Interface Protocol=0A#=0A# end of ARM System Control and Manag=
ement Interface Protocol=0A=0A# CONFIG_EDD is not set=0ACONFIG_FIRMWARE_M=
EMMAP=3Dy=0ACONFIG_DMIID=3Dy=0ACONFIG_DMI_SYSFS=3Dy=0ACONFIG_DMI_SCAN_MAC=
HINE_NON_EFI_FALLBACK=3Dy=0A# CONFIG_ISCSI_IBFT is not set=0A# CONFIG_FW_=
CFG_SYSFS is not set=0ACONFIG_SYSFB=3Dy=0A# CONFIG_SYSFB_SIMPLEFB is not =
set=0A# CONFIG_GOOGLE_FIRMWARE is not set=0A=0A#=0A# EFI (Extensible Firm=
ware Interface) Support=0A#=0A# CONFIG_EFI_VARS is not set=0ACONFIG_EFI_E=
SRT=3Dy=0ACONFIG_EFI_VARS_PSTORE=3Dy=0A# CONFIG_EFI_VARS_PSTORE_DEFAULT_D=
ISABLE is not set=0ACONFIG_EFI_RUNTIME_MAP=3Dy=0A# CONFIG_EFI_FAKE_MEMMAP=
 is not set=0ACONFIG_EFI_SOFT_RESERVE=3Dy=0ACONFIG_EFI_DXE_MEM_ATTRIBUTES=
=3Dy=0ACONFIG_EFI_RUNTIME_WRAPPERS=3Dy=0ACONFIG_EFI_GENERIC_STUB_INITRD_C=
MDLINE_LOADER=3Dy=0A# CONFIG_EFI_BOOTLOADER_CONTROL is not set=0A# CONFIG=
_EFI_CAPSULE_LOADER is not set=0A# CONFIG_EFI_TEST is not set=0ACONFIG_EF=
I_DEV_PATH_PARSER=3Dy=0ACONFIG_APPLE_PROPERTIES=3Dy=0ACONFIG_RESET_ATTACK=
_MITIGATION=3Dy=0A# CONFIG_EFI_RCI2_TABLE is not set=0A# CONFIG_EFI_DISAB=
LE_PCI_DMA is not set=0ACONFIG_EFI_EARLYCON=3Dy=0ACONFIG_EFI_CUSTOM_SSDT_=
OVERLAYS=3Dy=0ACONFIG_EFI_DISABLE_RUNTIME=3Dy=0A# CONFIG_EFI_COCO_SECRET =
is not set=0A# end of EFI (Extensible Firmware Interface) Support=0A=0ACO=
NFIG_UEFI_CPER=3Dy=0ACONFIG_UEFI_CPER_X86=3Dy=0A=0A#=0A# Tegra firmware d=
river=0A#=0A# end of Tegra firmware driver=0A# end of Firmware Drivers=0A=
=0A# CONFIG_GNSS is not set=0A# CONFIG_MTD is not set=0A# CONFIG_OF is no=
t set=0ACONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy=0A# CONFIG_PARPORT is not s=
et=0ACONFIG_PNP=3Dy=0A# CONFIG_PNP_DEBUG_MESSAGES is not set=0A=0A#=0A# P=
rotocols=0A#=0ACONFIG_PNPACPI=3Dy=0ACONFIG_BLK_DEV=3Dy=0A# CONFIG_BLK_DEV=
_NULL_BLK is not set=0A# CONFIG_BLK_DEV_FD is not set=0A# CONFIG_BLK_DEV_=
PCIESSD_MTIP32XX is not set=0A# CONFIG_ZRAM is not set=0A# CONFIG_BLK_DEV=
_LOOP is not set=0A# CONFIG_BLK_DEV_DRBD is not set=0A# CONFIG_BLK_DEV_NB=
D is not set=0A# CONFIG_BLK_DEV_SX8 is not set=0A# CONFIG_BLK_DEV_RAM is =
not set=0A# CONFIG_CDROM_PKTCDVD is not set=0A# CONFIG_ATA_OVER_ETH is no=
t set=0A# CONFIG_BLK_DEV_RBD is not set=0A=0A#=0A# NVME Support=0A#=0A# C=
ONFIG_BLK_DEV_NVME is not set=0A# CONFIG_NVME_FC is not set=0A# CONFIG_NV=
ME_TCP is not set=0A# CONFIG_NVME_TARGET is not set=0A# end of NVME Suppo=
rt=0A=0A#=0A# Misc devices=0A#=0A# CONFIG_AD525X_DPOT is not set=0A# CONF=
IG_DUMMY_IRQ is not set=0A# CONFIG_IBM_ASM is not set=0A# CONFIG_PHANTOM =
is not set=0A# CONFIG_TIFM_CORE is not set=0A# CONFIG_ICS932S401 is not s=
et=0A# CONFIG_ENCLOSURE_SERVICES is not set=0A# CONFIG_HP_ILO is not set=0A=
# CONFIG_APDS9802ALS is not set=0A# CONFIG_ISL29003 is not set=0A# CONFIG=
_ISL29020 is not set=0A# CONFIG_SENSORS_TSL2550 is not set=0A# CONFIG_SEN=
SORS_BH1770 is not set=0A# CONFIG_SENSORS_APDS990X is not set=0A# CONFIG_=
HMC6352 is not set=0A# CONFIG_DS1682 is not set=0A# CONFIG_LATTICE_ECP3_C=
ONFIG is not set=0A# CONFIG_SRAM is not set=0A# CONFIG_DW_XDATA_PCIE is n=
ot set=0A# CONFIG_PCI_ENDPOINT_TEST is not set=0A# CONFIG_XILINX_SDFEC is=
 not set=0A# CONFIG_C2PORT is not set=0A=0A#=0A# EEPROM support=0A#=0A# C=
ONFIG_EEPROM_AT24 is not set=0A# CONFIG_EEPROM_AT25 is not set=0A# CONFIG=
_EEPROM_LEGACY is not set=0A# CONFIG_EEPROM_MAX6875 is not set=0A# CONFIG=
_EEPROM_93CX6 is not set=0A# CONFIG_EEPROM_93XX46 is not set=0A# CONFIG_E=
EPROM_IDT_89HPESX is not set=0A# CONFIG_EEPROM_EE1004 is not set=0A# end =
of EEPROM support=0A=0A# CONFIG_CB710_CORE is not set=0A=0A#=0A# Texas In=
struments shared transport line discipline=0A#=0A# CONFIG_TI_ST is not se=
t=0A# end of Texas Instruments shared transport line discipline=0A=0A# CO=
NFIG_SENSORS_LIS3_I2C is not set=0A# CONFIG_ALTERA_STAPL is not set=0ACON=
FIG_INTEL_MEI=3Dm=0ACONFIG_INTEL_MEI_ME=3Dm=0A# CONFIG_INTEL_MEI_TXE is n=
ot set=0A# CONFIG_INTEL_MEI_GSC is not set=0A# CONFIG_INTEL_MEI_HDCP is n=
ot set=0A# CONFIG_INTEL_MEI_PXP is not set=0A# CONFIG_VMWARE_VMCI is not =
set=0A# CONFIG_GENWQE is not set=0A# CONFIG_ECHO is not set=0A# CONFIG_BC=
M_VK is not set=0A# CONFIG_MISC_ALCOR_PCI is not set=0A# CONFIG_MISC_RTSX=
_PCI is not set=0A# CONFIG_MISC_RTSX_USB is not set=0A# CONFIG_HABANA_AI =
is not set=0A# CONFIG_UACCE is not set=0A# CONFIG_PVPANIC is not set=0A# =
end of Misc devices=0A=0A#=0A# SCSI device support=0A#=0ACONFIG_SCSI_MOD=3D=
m=0A# CONFIG_RAID_ATTRS is not set=0ACONFIG_SCSI_COMMON=3Dm=0ACONFIG_SCSI=
=3Dm=0ACONFIG_SCSI_DMA=3Dy=0A# CONFIG_SCSI_PROC_FS is not set=0A=0A#=0A# =
SCSI support type (disk, tape, CD-ROM)=0A#=0ACONFIG_BLK_DEV_SD=3Dm=0A# CO=
NFIG_CHR_DEV_ST is not set=0A# CONFIG_BLK_DEV_SR is not set=0ACONFIG_CHR_=
DEV_SG=3Dm=0ACONFIG_BLK_DEV_BSG=3Dy=0A# CONFIG_CHR_DEV_SCH is not set=0AC=
ONFIG_SCSI_CONSTANTS=3Dy=0ACONFIG_SCSI_LOGGING=3Dy=0ACONFIG_SCSI_SCAN_ASY=
NC=3Dy=0A=0A#=0A# SCSI Transports=0A#=0A# CONFIG_SCSI_SPI_ATTRS is not se=
t=0A# CONFIG_SCSI_FC_ATTRS is not set=0A# CONFIG_SCSI_ISCSI_ATTRS is not =
set=0A# CONFIG_SCSI_SAS_ATTRS is not set=0A# CONFIG_SCSI_SAS_LIBSAS is no=
t set=0A# CONFIG_SCSI_SRP_ATTRS is not set=0A# end of SCSI Transports=0A=0A=
CONFIG_SCSI_LOWLEVEL=3Dy=0A# CONFIG_ISCSI_TCP is not set=0A# CONFIG_ISCSI=
_BOOT_SYSFS is not set=0A# CONFIG_SCSI_CXGB3_ISCSI is not set=0A# CONFIG_=
SCSI_CXGB4_ISCSI is not set=0A# CONFIG_SCSI_BNX2_ISCSI is not set=0A# CON=
FIG_BE2ISCSI is not set=0A# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A# CO=
NFIG_SCSI_HPSA is not set=0A# CONFIG_SCSI_3W_9XXX is not set=0A# CONFIG_S=
CSI_3W_SAS is not set=0A# CONFIG_SCSI_ACARD is not set=0A# CONFIG_SCSI_AA=
CRAID is not set=0A# CONFIG_SCSI_AIC7XXX is not set=0A# CONFIG_SCSI_AIC79=
XX is not set=0A# CONFIG_SCSI_AIC94XX is not set=0A# CONFIG_SCSI_MVSAS is=
 not set=0A# CONFIG_SCSI_MVUMI is not set=0A# CONFIG_SCSI_DPT_I2O is not =
set=0A# CONFIG_SCSI_ADVANSYS is not set=0A# CONFIG_SCSI_ARCMSR is not set=
=0A# CONFIG_SCSI_ESAS2R is not set=0ACONFIG_MEGARAID_NEWGEN=3Dy=0A# CONFI=
G_MEGARAID_MM is not set=0A# CONFIG_MEGARAID_LEGACY is not set=0A# CONFIG=
_MEGARAID_SAS is not set=0A# CONFIG_SCSI_MPT3SAS is not set=0A# CONFIG_SC=
SI_MPT2SAS is not set=0A# CONFIG_SCSI_MPI3MR is not set=0A# CONFIG_SCSI_S=
MARTPQI is not set=0A# CONFIG_SCSI_HPTIOP is not set=0A# CONFIG_SCSI_BUSL=
OGIC is not set=0A# CONFIG_SCSI_MYRB is not set=0A# CONFIG_SCSI_MYRS is n=
ot set=0A# CONFIG_VMWARE_PVSCSI is not set=0A# CONFIG_SCSI_SNIC is not se=
t=0A# CONFIG_SCSI_DMX3191D is not set=0A# CONFIG_SCSI_FDOMAIN_PCI is not =
set=0A# CONFIG_SCSI_ISCI is not set=0A# CONFIG_SCSI_IPS is not set=0A# CO=
NFIG_SCSI_INITIO is not set=0A# CONFIG_SCSI_INIA100 is not set=0A# CONFIG=
_SCSI_STEX is not set=0A# CONFIG_SCSI_SYM53C8XX_2 is not set=0A# CONFIG_S=
CSI_IPR is not set=0A# CONFIG_SCSI_QLOGIC_1280 is not set=0A# CONFIG_SCSI=
_QLA_ISCSI is not set=0A# CONFIG_SCSI_DC395x is not set=0A# CONFIG_SCSI_A=
M53C974 is not set=0A# CONFIG_SCSI_WD719X is not set=0A# CONFIG_SCSI_DEBU=
G is not set=0A# CONFIG_SCSI_PMCRAID is not set=0A# CONFIG_SCSI_PM8001 is=
 not set=0ACONFIG_SCSI_DH=3Dy=0A# CONFIG_SCSI_DH_RDAC is not set=0A# CONF=
IG_SCSI_DH_HP_SW is not set=0A# CONFIG_SCSI_DH_EMC is not set=0A# CONFIG_=
SCSI_DH_ALUA is not set=0A# end of SCSI device support=0A=0ACONFIG_ATA=3D=
m=0ACONFIG_SATA_HOST=3Dy=0ACONFIG_PATA_TIMINGS=3Dy=0ACONFIG_ATA_VERBOSE_E=
RROR=3Dy=0ACONFIG_ATA_FORCE=3Dy=0ACONFIG_ATA_ACPI=3Dy=0ACONFIG_SATA_ZPODD=
=3Dy=0ACONFIG_SATA_PMP=3Dy=0A=0A#=0A# Controllers with non-SFF native int=
erface=0A#=0ACONFIG_SATA_AHCI=3Dm=0ACONFIG_SATA_MOBILE_LPM_POLICY=3D3=0A#=
 CONFIG_SATA_AHCI_PLATFORM is not set=0A# CONFIG_SATA_INIC162X is not set=
=0ACONFIG_SATA_ACARD_AHCI=3Dm=0A# CONFIG_SATA_SIL24 is not set=0ACONFIG_A=
TA_SFF=3Dy=0A=0A#=0A# SFF controllers with custom DMA interface=0A#=0A# C=
ONFIG_PDC_ADMA is not set=0A# CONFIG_SATA_QSTOR is not set=0A# CONFIG_SAT=
A_SX4 is not set=0ACONFIG_ATA_BMDMA=3Dy=0A=0A#=0A# SATA SFF controllers w=
ith BMDMA=0A#=0A# CONFIG_ATA_PIIX is not set=0A# CONFIG_SATA_DWC is not s=
et=0A# CONFIG_SATA_MV is not set=0A# CONFIG_SATA_NV is not set=0A# CONFIG=
_SATA_PROMISE is not set=0A# CONFIG_SATA_SIL is not set=0A# CONFIG_SATA_S=
IS is not set=0A# CONFIG_SATA_SVW is not set=0A# CONFIG_SATA_ULI is not s=
et=0A# CONFIG_SATA_VIA is not set=0A# CONFIG_SATA_VITESSE is not set=0A=0A=
#=0A# PATA SFF controllers with BMDMA=0A#=0A# CONFIG_PATA_ALI is not set=0A=
# CONFIG_PATA_AMD is not set=0A# CONFIG_PATA_ARTOP is not set=0A# CONFIG_=
PATA_ATIIXP is not set=0A# CONFIG_PATA_ATP867X is not set=0A# CONFIG_PATA=
_CMD64X is not set=0A# CONFIG_PATA_CYPRESS is not set=0A# CONFIG_PATA_EFA=
R is not set=0A# CONFIG_PATA_HPT366 is not set=0A# CONFIG_PATA_HPT37X is =
not set=0A# CONFIG_PATA_HPT3X2N is not set=0A# CONFIG_PATA_HPT3X3 is not =
set=0A# CONFIG_PATA_IT8213 is not set=0A# CONFIG_PATA_IT821X is not set=0A=
# CONFIG_PATA_JMICRON is not set=0A# CONFIG_PATA_MARVELL is not set=0A# C=
ONFIG_PATA_NETCELL is not set=0A# CONFIG_PATA_NINJA32 is not set=0A# CONF=
IG_PATA_NS87415 is not set=0A# CONFIG_PATA_OLDPIIX is not set=0A# CONFIG_=
PATA_OPTIDMA is not set=0A# CONFIG_PATA_PDC2027X is not set=0A# CONFIG_PA=
TA_PDC_OLD is not set=0A# CONFIG_PATA_RADISYS is not set=0A# CONFIG_PATA_=
RDC is not set=0A# CONFIG_PATA_SCH is not set=0A# CONFIG_PATA_SERVERWORKS=
 is not set=0A# CONFIG_PATA_SIL680 is not set=0A# CONFIG_PATA_SIS is not =
set=0A# CONFIG_PATA_TOSHIBA is not set=0A# CONFIG_PATA_TRIFLEX is not set=
=0A# CONFIG_PATA_VIA is not set=0A# CONFIG_PATA_WINBOND is not set=0A=0A#=
=0A# PIO-only SFF controllers=0A#=0A# CONFIG_PATA_CMD640_PCI is not set=0A=
# CONFIG_PATA_MPIIX is not set=0A# CONFIG_PATA_NS87410 is not set=0A# CON=
FIG_PATA_OPTI is not set=0A# CONFIG_PATA_PLATFORM is not set=0A# CONFIG_P=
ATA_RZ1000 is not set=0A=0A#=0A# Generic fallback / legacy drivers=0A#=0A=
# CONFIG_PATA_ACPI is not set=0A# CONFIG_ATA_GENERIC is not set=0A# CONFI=
G_PATA_LEGACY is not set=0ACONFIG_MD=3Dy=0A# CONFIG_BLK_DEV_MD is not set=
=0A# CONFIG_BCACHE is not set=0A# CONFIG_BLK_DEV_DM is not set=0A# CONFIG=
_DM_AUDIT is not set=0A# CONFIG_TARGET_CORE is not set=0ACONFIG_FUSION=3D=
y=0A# CONFIG_FUSION_SPI is not set=0A# CONFIG_FUSION_SAS is not set=0ACON=
FIG_FUSION_MAX_SGE=3D128=0A# CONFIG_FUSION_LOGGING is not set=0A=0A#=0A# =
IEEE 1394 (FireWire) support=0A#=0A# CONFIG_FIREWIRE is not set=0A# CONFI=
G_FIREWIRE_NOSY is not set=0A# end of IEEE 1394 (FireWire) support=0A=0AC=
ONFIG_MACINTOSH_DRIVERS=3Dy=0ACONFIG_MAC_EMUMOUSEBTN=3Dy=0ACONFIG_NETDEVI=
CES=3Dy=0ACONFIG_MII=3Dm=0ACONFIG_NET_CORE=3Dy=0A# CONFIG_BONDING is not =
set=0A# CONFIG_DUMMY is not set=0A# CONFIG_WIREGUARD is not set=0A# CONFI=
G_EQUALIZER is not set=0ACONFIG_NET_FC=3Dy=0A# CONFIG_NET_TEAM is not set=
=0A# CONFIG_MACVLAN is not set=0A# CONFIG_IPVLAN is not set=0A# CONFIG_VX=
LAN is not set=0A# CONFIG_GENEVE is not set=0A# CONFIG_BAREUDP is not set=
=0A# CONFIG_GTP is not set=0A# CONFIG_AMT is not set=0A# CONFIG_MACSEC is=
 not set=0A# CONFIG_NETCONSOLE is not set=0ACONFIG_TUN=3Dy=0A# CONFIG_TUN=
_VNET_CROSS_LE is not set=0A# CONFIG_VETH is not set=0A# CONFIG_NLMON is =
not set=0A# CONFIG_NET_VRF is not set=0A# CONFIG_ARCNET is not set=0ACONF=
IG_ETHERNET=3Dy=0ACONFIG_NET_VENDOR_3COM=3Dy=0A# CONFIG_VORTEX is not set=
=0A# CONFIG_TYPHOON is not set=0ACONFIG_NET_VENDOR_ADAPTEC=3Dy=0A# CONFIG=
_ADAPTEC_STARFIRE is not set=0ACONFIG_NET_VENDOR_AGERE=3Dy=0A# CONFIG_ET1=
31X is not set=0ACONFIG_NET_VENDOR_ALACRITECH=3Dy=0A# CONFIG_SLICOSS is n=
ot set=0ACONFIG_NET_VENDOR_ALTEON=3Dy=0A# CONFIG_ACENIC is not set=0A# CO=
NFIG_ALTERA_TSE is not set=0ACONFIG_NET_VENDOR_AMAZON=3Dy=0A# CONFIG_ENA_=
ETHERNET is not set=0ACONFIG_NET_VENDOR_AMD=3Dy=0A# CONFIG_AMD8111_ETH is=
 not set=0A# CONFIG_PCNET32 is not set=0A# CONFIG_AMD_XGBE is not set=0AC=
ONFIG_NET_VENDOR_AQUANTIA=3Dy=0A# CONFIG_AQTION is not set=0A# CONFIG_NET=
_VENDOR_ARC is not set=0ACONFIG_NET_VENDOR_ASIX=3Dy=0A# CONFIG_SPI_AX8879=
6C is not set=0ACONFIG_NET_VENDOR_ATHEROS=3Dy=0A# CONFIG_ATL2 is not set=0A=
# CONFIG_ATL1 is not set=0A# CONFIG_ATL1E is not set=0A# CONFIG_ATL1C is =
not set=0A# CONFIG_ALX is not set=0A# CONFIG_CX_ECAT is not set=0ACONFIG_=
NET_VENDOR_BROADCOM=3Dy=0A# CONFIG_B44 is not set=0A# CONFIG_BCMGENET is =
not set=0A# CONFIG_BNX2 is not set=0A# CONFIG_CNIC is not set=0A# CONFIG_=
TIGON3 is not set=0A# CONFIG_BNX2X is not set=0A# CONFIG_SYSTEMPORT is no=
t set=0A# CONFIG_BNXT is not set=0ACONFIG_NET_VENDOR_CADENCE=3Dy=0A# CONF=
IG_MACB is not set=0ACONFIG_NET_VENDOR_CAVIUM=3Dy=0A# CONFIG_THUNDER_NIC_=
PF is not set=0A# CONFIG_THUNDER_NIC_VF is not set=0A# CONFIG_THUNDER_NIC=
_BGX is not set=0A# CONFIG_THUNDER_NIC_RGX is not set=0A# CONFIG_CAVIUM_P=
TP is not set=0A# CONFIG_LIQUIDIO is not set=0A# CONFIG_LIQUIDIO_VF is no=
t set=0ACONFIG_NET_VENDOR_CHELSIO=3Dy=0A# CONFIG_CHELSIO_T1 is not set=0A=
# CONFIG_CHELSIO_T3 is not set=0A# CONFIG_CHELSIO_T4 is not set=0A# CONFI=
G_CHELSIO_T4VF is not set=0ACONFIG_NET_VENDOR_CISCO=3Dy=0A# CONFIG_ENIC i=
s not set=0ACONFIG_NET_VENDOR_CORTINA=3Dy=0ACONFIG_NET_VENDOR_DAVICOM=3Dy=
=0A# CONFIG_DM9051 is not set=0A# CONFIG_DNET is not set=0ACONFIG_NET_VEN=
DOR_DEC=3Dy=0ACONFIG_NET_TULIP=3Dy=0A# CONFIG_DE2104X is not set=0A# CONF=
IG_TULIP is not set=0A# CONFIG_WINBOND_840 is not set=0A# CONFIG_DM9102 i=
s not set=0A# CONFIG_ULI526X is not set=0ACONFIG_NET_VENDOR_DLINK=3Dy=0A#=
 CONFIG_DL2K is not set=0A# CONFIG_SUNDANCE is not set=0ACONFIG_NET_VENDO=
R_EMULEX=3Dy=0A# CONFIG_BE2NET is not set=0ACONFIG_NET_VENDOR_ENGLEDER=3D=
y=0A# CONFIG_TSNEP is not set=0ACONFIG_NET_VENDOR_EZCHIP=3Dy=0ACONFIG_NET=
_VENDOR_FUNGIBLE=3Dy=0A# CONFIG_FUN_ETH is not set=0ACONFIG_NET_VENDOR_GO=
OGLE=3Dy=0A# CONFIG_GVE is not set=0ACONFIG_NET_VENDOR_HUAWEI=3Dy=0A# CON=
FIG_HINIC is not set=0ACONFIG_NET_VENDOR_I825XX=3Dy=0ACONFIG_NET_VENDOR_I=
NTEL=3Dy=0A# CONFIG_E100 is not set=0A# CONFIG_E1000 is not set=0ACONFIG_=
E1000E=3Dm=0ACONFIG_E1000E_HWTS=3Dy=0ACONFIG_IGB=3Dm=0ACONFIG_IGB_HWMON=3D=
y=0A# CONFIG_IGBVF is not set=0A# CONFIG_IXGB is not set=0A# CONFIG_IXGBE=
 is not set=0A# CONFIG_IXGBEVF is not set=0A# CONFIG_I40E is not set=0A# =
CONFIG_I40EVF is not set=0A# CONFIG_ICE is not set=0A# CONFIG_FM10K is no=
t set=0A# CONFIG_IGC is not set=0A# CONFIG_JME is not set=0ACONFIG_NET_VE=
NDOR_LITEX=3Dy=0ACONFIG_NET_VENDOR_MARVELL=3Dy=0A# CONFIG_MVMDIO is not s=
et=0A# CONFIG_SKGE is not set=0A# CONFIG_SKY2 is not set=0A# CONFIG_OCTEO=
N_EP is not set=0ACONFIG_NET_VENDOR_MELLANOX=3Dy=0A# CONFIG_MLX4_EN is no=
t set=0A# CONFIG_MLX5_CORE is not set=0A# CONFIG_MLXSW_CORE is not set=0A=
# CONFIG_MLXFW is not set=0ACONFIG_NET_VENDOR_MICREL=3Dy=0A# CONFIG_KS884=
2 is not set=0A# CONFIG_KS8851 is not set=0A# CONFIG_KS8851_MLL is not se=
t=0A# CONFIG_KSZ884X_PCI is not set=0ACONFIG_NET_VENDOR_MICROCHIP=3Dy=0A#=
 CONFIG_ENC28J60 is not set=0A# CONFIG_ENCX24J600 is not set=0A# CONFIG_L=
AN743X is not set=0ACONFIG_NET_VENDOR_MICROSEMI=3Dy=0ACONFIG_NET_VENDOR_M=
ICROSOFT=3Dy=0ACONFIG_NET_VENDOR_MYRI=3Dy=0A# CONFIG_MYRI10GE is not set=0A=
# CONFIG_FEALNX is not set=0ACONFIG_NET_VENDOR_NI=3Dy=0A# CONFIG_NI_XGE_M=
ANAGEMENT_ENET is not set=0ACONFIG_NET_VENDOR_NATSEMI=3Dy=0A# CONFIG_NATS=
EMI is not set=0A# CONFIG_NS83820 is not set=0ACONFIG_NET_VENDOR_NETERION=
=3Dy=0A# CONFIG_S2IO is not set=0A# CONFIG_VXGE is not set=0ACONFIG_NET_V=
ENDOR_NETRONOME=3Dy=0A# CONFIG_NFP is not set=0ACONFIG_NET_VENDOR_8390=3D=
y=0A# CONFIG_NE2K_PCI is not set=0ACONFIG_NET_VENDOR_NVIDIA=3Dy=0A# CONFI=
G_FORCEDETH is not set=0ACONFIG_NET_VENDOR_OKI=3Dy=0A# CONFIG_ETHOC is no=
t set=0ACONFIG_NET_VENDOR_PACKET_ENGINES=3Dy=0A# CONFIG_HAMACHI is not se=
t=0A# CONFIG_YELLOWFIN is not set=0ACONFIG_NET_VENDOR_PENSANDO=3Dy=0A# CO=
NFIG_IONIC is not set=0ACONFIG_NET_VENDOR_QLOGIC=3Dy=0A# CONFIG_QLA3XXX i=
s not set=0A# CONFIG_QLCNIC is not set=0A# CONFIG_NETXEN_NIC is not set=0A=
# CONFIG_QED is not set=0ACONFIG_NET_VENDOR_BROCADE=3Dy=0A# CONFIG_BNA is=
 not set=0ACONFIG_NET_VENDOR_QUALCOMM=3Dy=0A# CONFIG_QCOM_EMAC is not set=
=0A# CONFIG_RMNET is not set=0ACONFIG_NET_VENDOR_RDC=3Dy=0A# CONFIG_R6040=
 is not set=0ACONFIG_NET_VENDOR_REALTEK=3Dy=0A# CONFIG_8139CP is not set=0A=
# CONFIG_8139TOO is not set=0A# CONFIG_R8169 is not set=0ACONFIG_NET_VEND=
OR_RENESAS=3Dy=0ACONFIG_NET_VENDOR_ROCKER=3Dy=0ACONFIG_NET_VENDOR_SAMSUNG=
=3Dy=0A# CONFIG_SXGBE_ETH is not set=0A# CONFIG_NET_VENDOR_SEEQ is not se=
t=0ACONFIG_NET_VENDOR_SILAN=3Dy=0A# CONFIG_SC92031 is not set=0ACONFIG_NE=
T_VENDOR_SIS=3Dy=0A# CONFIG_SIS900 is not set=0A# CONFIG_SIS190 is not se=
t=0ACONFIG_NET_VENDOR_SOLARFLARE=3Dy=0A# CONFIG_SFC is not set=0A# CONFIG=
_SFC_FALCON is not set=0A# CONFIG_SFC_SIENA is not set=0ACONFIG_NET_VENDO=
R_SMSC=3Dy=0A# CONFIG_EPIC100 is not set=0A# CONFIG_SMSC911X is not set=0A=
# CONFIG_SMSC9420 is not set=0ACONFIG_NET_VENDOR_SOCIONEXT=3Dy=0ACONFIG_N=
ET_VENDOR_STMICRO=3Dy=0A# CONFIG_STMMAC_ETH is not set=0ACONFIG_NET_VENDO=
R_SUN=3Dy=0A# CONFIG_HAPPYMEAL is not set=0A# CONFIG_SUNGEM is not set=0A=
# CONFIG_CASSINI is not set=0A# CONFIG_NIU is not set=0ACONFIG_NET_VENDOR=
_SYNOPSYS=3Dy=0A# CONFIG_DWC_XLGMAC is not set=0ACONFIG_NET_VENDOR_TEHUTI=
=3Dy=0A# CONFIG_TEHUTI is not set=0ACONFIG_NET_VENDOR_TI=3Dy=0A# CONFIG_T=
I_CPSW_PHY_SEL is not set=0A# CONFIG_TLAN is not set=0ACONFIG_NET_VENDOR_=
VERTEXCOM=3Dy=0A# CONFIG_MSE102X is not set=0ACONFIG_NET_VENDOR_VIA=3Dy=0A=
# CONFIG_VIA_RHINE is not set=0A# CONFIG_VIA_VELOCITY is not set=0ACONFIG=
_NET_VENDOR_WIZNET=3Dy=0A# CONFIG_WIZNET_W5100 is not set=0A# CONFIG_WIZN=
ET_W5300 is not set=0ACONFIG_NET_VENDOR_XILINX=3Dy=0A# CONFIG_XILINX_EMAC=
LITE is not set=0A# CONFIG_XILINX_AXI_EMAC is not set=0A# CONFIG_XILINX_L=
L_TEMAC is not set=0ACONFIG_FDDI=3Dy=0A# CONFIG_DEFXX is not set=0A# CONF=
IG_SKFP is not set=0ACONFIG_HIPPI=3Dy=0A# CONFIG_ROADRUNNER is not set=0A=
# CONFIG_NET_SB1000 is not set=0ACONFIG_PHYLIB=3Dm=0ACONFIG_SWPHY=3Dy=0A#=
 CONFIG_LED_TRIGGER_PHY is not set=0ACONFIG_FIXED_PHY=3Dm=0A=0A#=0A# MII =
PHY device drivers=0A#=0A# CONFIG_AMD_PHY is not set=0A# CONFIG_ADIN_PHY =
is not set=0A# CONFIG_ADIN1100_PHY is not set=0A# CONFIG_AQUANTIA_PHY is =
not set=0ACONFIG_AX88796B_PHY=3Dm=0A# CONFIG_BROADCOM_PHY is not set=0A# =
CONFIG_BCM54140_PHY is not set=0A# CONFIG_BCM7XXX_PHY is not set=0A# CONF=
IG_BCM84881_PHY is not set=0A# CONFIG_BCM87XX_PHY is not set=0A# CONFIG_C=
ICADA_PHY is not set=0A# CONFIG_CORTINA_PHY is not set=0A# CONFIG_DAVICOM=
_PHY is not set=0A# CONFIG_ICPLUS_PHY is not set=0A# CONFIG_LXT_PHY is no=
t set=0A# CONFIG_INTEL_XWAY_PHY is not set=0A# CONFIG_LSI_ET1011C_PHY is =
not set=0A# CONFIG_MARVELL_PHY is not set=0A# CONFIG_MARVELL_10G_PHY is n=
ot set=0A# CONFIG_MARVELL_88X2222_PHY is not set=0A# CONFIG_MAXLINEAR_GPH=
Y is not set=0A# CONFIG_MEDIATEK_GE_PHY is not set=0A# CONFIG_MICREL_PHY =
is not set=0A# CONFIG_MICROCHIP_PHY is not set=0A# CONFIG_MICROCHIP_T1_PH=
Y is not set=0A# CONFIG_MICROSEMI_PHY is not set=0A# CONFIG_MOTORCOMM_PHY=
 is not set=0A# CONFIG_NATIONAL_PHY is not set=0A# CONFIG_NXP_C45_TJA11XX=
_PHY is not set=0A# CONFIG_NXP_TJA11XX_PHY is not set=0A# CONFIG_AT803X_P=
HY is not set=0A# CONFIG_QSEMI_PHY is not set=0A# CONFIG_REALTEK_PHY is n=
ot set=0A# CONFIG_RENESAS_PHY is not set=0A# CONFIG_ROCKCHIP_PHY is not s=
et=0A# CONFIG_SMSC_PHY is not set=0A# CONFIG_STE10XP is not set=0A# CONFI=
G_TERANETICS_PHY is not set=0A# CONFIG_DP83822_PHY is not set=0A# CONFIG_=
DP83TC811_PHY is not set=0A# CONFIG_DP83848_PHY is not set=0A# CONFIG_DP8=
3867_PHY is not set=0A# CONFIG_DP83869_PHY is not set=0A# CONFIG_DP83TD51=
0_PHY is not set=0A# CONFIG_VITESSE_PHY is not set=0A# CONFIG_XILINX_GMII=
2RGMII is not set=0A# CONFIG_MICREL_KS8995MA is not set=0ACONFIG_MDIO_DEV=
ICE=3Dm=0ACONFIG_MDIO_BUS=3Dm=0ACONFIG_FWNODE_MDIO=3Dm=0ACONFIG_ACPI_MDIO=
=3Dm=0ACONFIG_MDIO_DEVRES=3Dm=0A# CONFIG_MDIO_BITBANG is not set=0A# CONF=
IG_MDIO_BCM_UNIMAC is not set=0A# CONFIG_MDIO_MVUSB is not set=0A# CONFIG=
_MDIO_MSCC_MIIM is not set=0A# CONFIG_MDIO_THUNDER is not set=0A=0A#=0A# =
MDIO Multiplexers=0A#=0A=0A#=0A# PCS device drivers=0A#=0A# CONFIG_PCS_XP=
CS is not set=0A# end of PCS device drivers=0A=0A# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=0A#=0A# Host-side USB support is needed for U=
SB Network Adapter support=0A#=0ACONFIG_USB_NET_DRIVERS=3Dm=0A# CONFIG_US=
B_CATC is not set=0A# CONFIG_USB_KAWETH is not set=0A# CONFIG_USB_PEGASUS=
 is not set=0A# CONFIG_USB_RTL8150 is not set=0A# CONFIG_USB_RTL8152 is n=
ot set=0A# CONFIG_USB_LAN78XX is not set=0ACONFIG_USB_USBNET=3Dm=0ACONFIG=
_USB_NET_AX8817X=3Dm=0A# CONFIG_USB_NET_AX88179_178A is not set=0A# CONFI=
G_USB_NET_CDCETHER is not set=0A# CONFIG_USB_NET_CDC_EEM is not set=0A# C=
ONFIG_USB_NET_CDC_NCM is not set=0A# CONFIG_USB_NET_HUAWEI_CDC_NCM is not=
 set=0A# CONFIG_USB_NET_CDC_MBIM is not set=0A# CONFIG_USB_NET_DM9601 is =
not set=0A# CONFIG_USB_NET_SR9700 is not set=0A# CONFIG_USB_NET_SR9800 is=
 not set=0A# CONFIG_USB_NET_SMSC75XX is not set=0A# CONFIG_USB_NET_SMSC95=
XX is not set=0A# CONFIG_USB_NET_GL620A is not set=0A# CONFIG_USB_NET_NET=
1080 is not set=0A# CONFIG_USB_NET_PLUSB is not set=0A# CONFIG_USB_NET_MC=
S7830 is not set=0A# CONFIG_USB_NET_RNDIS_HOST is not set=0A# CONFIG_USB_=
NET_CDC_SUBSET is not set=0A# CONFIG_USB_NET_ZAURUS is not set=0A# CONFIG=
_USB_NET_CX82310_ETH is not set=0A# CONFIG_USB_NET_KALMIA is not set=0A# =
CONFIG_USB_NET_QMI_WWAN is not set=0A# CONFIG_USB_HSO is not set=0A# CONF=
IG_USB_NET_INT51X1 is not set=0A# CONFIG_USB_IPHETH is not set=0A# CONFIG=
_USB_SIERRA_NET is not set=0A# CONFIG_USB_NET_CH9200 is not set=0A# CONFI=
G_USB_NET_AQC111 is not set=0ACONFIG_WLAN=3Dy=0ACONFIG_WLAN_VENDOR_ADMTEK=
=3Dy=0A# CONFIG_ADM8211 is not set=0ACONFIG_WLAN_VENDOR_ATH=3Dy=0A# CONFI=
G_ATH_DEBUG is not set=0A# CONFIG_ATH5K is not set=0ACONFIG_ATH5K_PCI=3Dy=
=0A# CONFIG_ATH9K is not set=0A# CONFIG_ATH9K_HTC is not set=0A# CONFIG_C=
ARL9170 is not set=0A# CONFIG_ATH6KL is not set=0A# CONFIG_AR5523 is not =
set=0A# CONFIG_WIL6210 is not set=0A# CONFIG_ATH10K is not set=0A# CONFIG=
_WCN36XX is not set=0ACONFIG_WLAN_VENDOR_ATMEL=3Dy=0A# CONFIG_ATMEL is no=
t set=0A# CONFIG_AT76C50X_USB is not set=0ACONFIG_WLAN_VENDOR_BROADCOM=3D=
y=0A# CONFIG_B43 is not set=0A# CONFIG_B43LEGACY is not set=0A# CONFIG_BR=
CMSMAC is not set=0A# CONFIG_BRCMFMAC is not set=0ACONFIG_WLAN_VENDOR_CIS=
CO=3Dy=0A# CONFIG_AIRO is not set=0ACONFIG_WLAN_VENDOR_INTEL=3Dy=0A# CONF=
IG_IPW2100 is not set=0A# CONFIG_IPW2200 is not set=0A# CONFIG_IWL4965 is=
 not set=0A# CONFIG_IWL3945 is not set=0ACONFIG_IWLWIFI=3Dm=0ACONFIG_IWLW=
IFI_LEDS=3Dy=0ACONFIG_IWLDVM=3Dm=0ACONFIG_IWLMVM=3Dm=0ACONFIG_IWLWIFI_OPM=
ODE_MODULAR=3Dy=0A=0A#=0A# Debugging Options=0A#=0ACONFIG_IWLWIFI_DEBUG=3D=
y=0ACONFIG_IWLWIFI_DEVICE_TRACING=3Dy=0A# end of Debugging Options=0A=0A#=
 CONFIG_IWLMEI is not set=0ACONFIG_WLAN_VENDOR_INTERSIL=3Dy=0A# CONFIG_HO=
STAP is not set=0A# CONFIG_HERMES is not set=0A# CONFIG_P54_COMMON is not=
 set=0ACONFIG_WLAN_VENDOR_MARVELL=3Dy=0A# CONFIG_LIBERTAS is not set=0A# =
CONFIG_LIBERTAS_THINFIRM is not set=0A# CONFIG_MWIFIEX is not set=0A# CON=
FIG_MWL8K is not set=0ACONFIG_WLAN_VENDOR_MEDIATEK=3Dy=0A# CONFIG_MT7601U=
 is not set=0A# CONFIG_MT76x0U is not set=0A# CONFIG_MT76x0E is not set=0A=
# CONFIG_MT76x2E is not set=0A# CONFIG_MT76x2U is not set=0A# CONFIG_MT76=
03E is not set=0A# CONFIG_MT7615E is not set=0A# CONFIG_MT7663U is not se=
t=0A# CONFIG_MT7663S is not set=0A# CONFIG_MT7915E is not set=0A# CONFIG_=
MT7921E is not set=0A# CONFIG_MT7921S is not set=0A# CONFIG_MT7921U is no=
t set=0ACONFIG_WLAN_VENDOR_MICROCHIP=3Dy=0A# CONFIG_WILC1000_SDIO is not =
set=0A# CONFIG_WILC1000_SPI is not set=0ACONFIG_WLAN_VENDOR_PURELIFI=3Dy=0A=
# CONFIG_PLFXLC is not set=0ACONFIG_WLAN_VENDOR_RALINK=3Dy=0A# CONFIG_RT2=
X00 is not set=0ACONFIG_WLAN_VENDOR_REALTEK=3Dy=0A# CONFIG_RTL8180 is not=
 set=0A# CONFIG_RTL8187 is not set=0ACONFIG_RTL_CARDS=3Dm=0A# CONFIG_RTL8=
192CE is not set=0A# CONFIG_RTL8192SE is not set=0A# CONFIG_RTL8192DE is =
not set=0A# CONFIG_RTL8723AE is not set=0A# CONFIG_RTL8723BE is not set=0A=
# CONFIG_RTL8188EE is not set=0A# CONFIG_RTL8192EE is not set=0A# CONFIG_=
RTL8821AE is not set=0A# CONFIG_RTL8192CU is not set=0A# CONFIG_RTL8XXXU =
is not set=0A# CONFIG_RTW88 is not set=0A# CONFIG_RTW89 is not set=0ACONF=
IG_WLAN_VENDOR_RSI=3Dy=0A# CONFIG_RSI_91X is not set=0ACONFIG_WLAN_VENDOR=
_SILABS=3Dy=0A# CONFIG_WFX is not set=0ACONFIG_WLAN_VENDOR_ST=3Dy=0A# CON=
FIG_CW1200 is not set=0A# CONFIG_WLAN_VENDOR_TI is not set=0ACONFIG_WLAN_=
VENDOR_ZYDAS=3Dy=0A# CONFIG_USB_ZD1201 is not set=0A# CONFIG_ZD1211RW is =
not set=0ACONFIG_WLAN_VENDOR_QUANTENNA=3Dy=0A# CONFIG_QTNFMAC_PCIE is not=
 set=0A# CONFIG_MAC80211_HWSIM is not set=0A# CONFIG_USB_NET_RNDIS_WLAN i=
s not set=0A# CONFIG_VIRT_WIFI is not set=0ACONFIG_WAN=3Dy=0A# CONFIG_HDL=
C is not set=0A=0A#=0A# Wireless WAN=0A#=0A# CONFIG_WWAN is not set=0A# e=
nd of Wireless WAN=0A=0A# CONFIG_VMXNET3 is not set=0A# CONFIG_FUJITSU_ES=
 is not set=0A# CONFIG_NETDEVSIM is not set=0A# CONFIG_NET_FAILOVER is no=
t set=0ACONFIG_ISDN=3Dy=0ACONFIG_ISDN_CAPI=3Dy=0A# CONFIG_MISDN is not se=
t=0A=0A#=0A# Input device support=0A#=0ACONFIG_INPUT=3Dy=0ACONFIG_INPUT_L=
EDS=3Dy=0A# CONFIG_INPUT_FF_MEMLESS is not set=0A# CONFIG_INPUT_SPARSEKMA=
P is not set=0A# CONFIG_INPUT_MATRIXKMAP is not set=0ACONFIG_INPUT_VIVALD=
IFMAP=3Dy=0A=0A#=0A# Userland interfaces=0A#=0ACONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0ACONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0ACONFIG_INPUT_JOYDEV=3Dm=0ACONFIG_I=
NPUT_EVDEV=3Dm=0A# CONFIG_INPUT_EVBUG is not set=0A=0A#=0A# Input Device =
Drivers=0A#=0ACONFIG_INPUT_KEYBOARD=3Dy=0A# CONFIG_KEYBOARD_ADP5588 is no=
t set=0A# CONFIG_KEYBOARD_ADP5589 is not set=0A# CONFIG_KEYBOARD_APPLESPI=
 is not set=0ACONFIG_KEYBOARD_ATKBD=3Dy=0A# CONFIG_KEYBOARD_QT1050 is not=
 set=0A# CONFIG_KEYBOARD_QT1070 is not set=0A# CONFIG_KEYBOARD_QT2160 is =
not set=0A# CONFIG_KEYBOARD_DLINK_DIR685 is not set=0A# CONFIG_KEYBOARD_L=
KKBD is not set=0A# CONFIG_KEYBOARD_GPIO is not set=0A# CONFIG_KEYBOARD_G=
PIO_POLLED is not set=0A# CONFIG_KEYBOARD_TCA6416 is not set=0A# CONFIG_K=
EYBOARD_TCA8418 is not set=0A# CONFIG_KEYBOARD_MATRIX is not set=0A# CONF=
IG_KEYBOARD_LM8323 is not set=0A# CONFIG_KEYBOARD_LM8333 is not set=0A# C=
ONFIG_KEYBOARD_MAX7359 is not set=0A# CONFIG_KEYBOARD_MCS is not set=0A# =
CONFIG_KEYBOARD_MPR121 is not set=0A# CONFIG_KEYBOARD_NEWTON is not set=0A=
# CONFIG_KEYBOARD_OPENCORES is not set=0A# CONFIG_KEYBOARD_SAMSUNG is not=
 set=0A# CONFIG_KEYBOARD_STOWAWAY is not set=0A# CONFIG_KEYBOARD_SUNKBD i=
s not set=0A# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set=0A# CONFIG_KEYBOARD=
_XTKBD is not set=0A# CONFIG_KEYBOARD_CYPRESS_SF is not set=0ACONFIG_INPU=
T_MOUSE=3Dy=0A# CONFIG_MOUSE_PS2 is not set=0A# CONFIG_MOUSE_SERIAL is no=
t set=0A# CONFIG_MOUSE_APPLETOUCH is not set=0A# CONFIG_MOUSE_BCM5974 is =
not set=0A# CONFIG_MOUSE_CYAPA is not set=0A# CONFIG_MOUSE_ELAN_I2C is no=
t set=0A# CONFIG_MOUSE_VSXXXAA is not set=0A# CONFIG_MOUSE_GPIO is not se=
t=0A# CONFIG_MOUSE_SYNAPTICS_I2C is not set=0A# CONFIG_MOUSE_SYNAPTICS_US=
B is not set=0ACONFIG_INPUT_JOYSTICK=3Dy=0A# CONFIG_JOYSTICK_ANALOG is no=
t set=0A# CONFIG_JOYSTICK_A3D is not set=0A# CONFIG_JOYSTICK_ADI is not s=
et=0A# CONFIG_JOYSTICK_COBRA is not set=0A# CONFIG_JOYSTICK_GF2K is not s=
et=0A# CONFIG_JOYSTICK_GRIP is not set=0A# CONFIG_JOYSTICK_GRIP_MP is not=
 set=0A# CONFIG_JOYSTICK_GUILLEMOT is not set=0A# CONFIG_JOYSTICK_INTERAC=
T is not set=0A# CONFIG_JOYSTICK_SIDEWINDER is not set=0A# CONFIG_JOYSTIC=
K_TMDC is not set=0A# CONFIG_JOYSTICK_IFORCE is not set=0A# CONFIG_JOYSTI=
CK_WARRIOR is not set=0A# CONFIG_JOYSTICK_MAGELLAN is not set=0A# CONFIG_=
JOYSTICK_SPACEORB is not set=0A# CONFIG_JOYSTICK_SPACEBALL is not set=0A#=
 CONFIG_JOYSTICK_STINGER is not set=0A# CONFIG_JOYSTICK_TWIDJOY is not se=
t=0A# CONFIG_JOYSTICK_ZHENHUA is not set=0A# CONFIG_JOYSTICK_AS5011 is no=
t set=0A# CONFIG_JOYSTICK_JOYDUMP is not set=0A# CONFIG_JOYSTICK_XPAD is =
not set=0A# CONFIG_JOYSTICK_PSXPAD_SPI is not set=0A# CONFIG_JOYSTICK_PXR=
C is not set=0A# CONFIG_JOYSTICK_QWIIC is not set=0A# CONFIG_JOYSTICK_FSI=
A6B is not set=0A# CONFIG_JOYSTICK_SENSEHAT is not set=0ACONFIG_INPUT_TAB=
LET=3Dy=0A# CONFIG_TABLET_USB_ACECAD is not set=0A# CONFIG_TABLET_USB_AIP=
TEK is not set=0A# CONFIG_TABLET_USB_HANWANG is not set=0A# CONFIG_TABLET=
_USB_KBTAB is not set=0A# CONFIG_TABLET_USB_PEGASUS is not set=0A# CONFIG=
_TABLET_SERIAL_WACOM4 is not set=0ACONFIG_INPUT_TOUCHSCREEN=3Dy=0A# CONFI=
G_TOUCHSCREEN_ADS7846 is not set=0A# CONFIG_TOUCHSCREEN_AD7877 is not set=
=0A# CONFIG_TOUCHSCREEN_AD7879 is not set=0A# CONFIG_TOUCHSCREEN_ATMEL_MX=
T is not set=0A# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set=0A# CONFIG_TOUC=
HSCREEN_BU21013 is not set=0A# CONFIG_TOUCHSCREEN_BU21029 is not set=0A# =
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set=0A# CONFIG_TOUCHSCREEN_CY8C=
TMA140 is not set=0A# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set=0A# CONFIG=
_TOUCHSCREEN_CYTTSP_CORE is not set=0A# CONFIG_TOUCHSCREEN_CYTTSP4_CORE i=
s not set=0A# CONFIG_TOUCHSCREEN_DYNAPRO is not set=0A# CONFIG_TOUCHSCREE=
N_HAMPSHIRE is not set=0A# CONFIG_TOUCHSCREEN_EETI is not set=0A# CONFIG_=
TOUCHSCREEN_EGALAX_SERIAL is not set=0A# CONFIG_TOUCHSCREEN_EXC3000 is no=
t set=0A# CONFIG_TOUCHSCREEN_FUJITSU is not set=0A# CONFIG_TOUCHSCREEN_GO=
ODIX is not set=0A# CONFIG_TOUCHSCREEN_HIDEEP is not set=0A# CONFIG_TOUCH=
SCREEN_HYCON_HY46XX is not set=0A# CONFIG_TOUCHSCREEN_ILI210X is not set=0A=
# CONFIG_TOUCHSCREEN_ILITEK is not set=0A# CONFIG_TOUCHSCREEN_S6SY761 is =
not set=0A# CONFIG_TOUCHSCREEN_GUNZE is not set=0A# CONFIG_TOUCHSCREEN_EK=
TF2127 is not set=0A# CONFIG_TOUCHSCREEN_ELAN is not set=0A# CONFIG_TOUCH=
SCREEN_ELO is not set=0A# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set=0A# C=
ONFIG_TOUCHSCREEN_WACOM_I2C is not set=0A# CONFIG_TOUCHSCREEN_MAX11801 is=
 not set=0A# CONFIG_TOUCHSCREEN_MCS5000 is not set=0A# CONFIG_TOUCHSCREEN=
_MMS114 is not set=0A# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set=0A# CONF=
IG_TOUCHSCREEN_MSG2638 is not set=0A# CONFIG_TOUCHSCREEN_MTOUCH is not se=
t=0A# CONFIG_TOUCHSCREEN_IMAGIS is not set=0A# CONFIG_TOUCHSCREEN_INEXIO =
is not set=0A# CONFIG_TOUCHSCREEN_MK712 is not set=0A# CONFIG_TOUCHSCREEN=
_PENMOUNT is not set=0A# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set=0A# CON=
FIG_TOUCHSCREEN_TOUCHRIGHT is not set=0A# CONFIG_TOUCHSCREEN_TOUCHWIN is =
not set=0A# CONFIG_TOUCHSCREEN_PIXCIR is not set=0A# CONFIG_TOUCHSCREEN_W=
DT87XX_I2C is not set=0A# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set=0A#=
 CONFIG_TOUCHSCREEN_TOUCHIT213 is not set=0A# CONFIG_TOUCHSCREEN_TSC_SERI=
O is not set=0A# CONFIG_TOUCHSCREEN_TSC2004 is not set=0A# CONFIG_TOUCHSC=
REEN_TSC2005 is not set=0A# CONFIG_TOUCHSCREEN_TSC2007 is not set=0A# CON=
FIG_TOUCHSCREEN_RM_TS is not set=0A# CONFIG_TOUCHSCREEN_SILEAD is not set=
=0A# CONFIG_TOUCHSCREEN_SIS_I2C is not set=0A# CONFIG_TOUCHSCREEN_ST1232 =
is not set=0A# CONFIG_TOUCHSCREEN_STMFTS is not set=0A# CONFIG_TOUCHSCREE=
N_SURFACE3_SPI is not set=0A# CONFIG_TOUCHSCREEN_SX8654 is not set=0A# CO=
NFIG_TOUCHSCREEN_TPS6507X is not set=0A# CONFIG_TOUCHSCREEN_ZET6223 is no=
t set=0A# CONFIG_TOUCHSCREEN_ZFORCE is not set=0A# CONFIG_TOUCHSCREEN_ROH=
M_BU21023 is not set=0A# CONFIG_TOUCHSCREEN_IQS5XX is not set=0A# CONFIG_=
TOUCHSCREEN_ZINITIX is not set=0ACONFIG_INPUT_MISC=3Dy=0A# CONFIG_INPUT_A=
D714X is not set=0A# CONFIG_INPUT_BMA150 is not set=0A# CONFIG_INPUT_E3X0=
_BUTTON is not set=0ACONFIG_INPUT_PCSPKR=3Dm=0A# CONFIG_INPUT_MMA8450 is =
not set=0A# CONFIG_INPUT_APANEL is not set=0A# CONFIG_INPUT_GPIO_BEEPER i=
s not set=0A# CONFIG_INPUT_GPIO_DECODER is not set=0A# CONFIG_INPUT_GPIO_=
VIBRA is not set=0A# CONFIG_INPUT_ATLAS_BTNS is not set=0A# CONFIG_INPUT_=
ATI_REMOTE2 is not set=0A# CONFIG_INPUT_KEYSPAN_REMOTE is not set=0A# CON=
FIG_INPUT_KXTJ9 is not set=0A# CONFIG_INPUT_POWERMATE is not set=0A# CONF=
IG_INPUT_YEALINK is not set=0A# CONFIG_INPUT_CM109 is not set=0A# CONFIG_=
INPUT_REGULATOR_HAPTIC is not set=0A# CONFIG_INPUT_UINPUT is not set=0A# =
CONFIG_INPUT_PCF8574 is not set=0A# CONFIG_INPUT_PWM_BEEPER is not set=0A=
# CONFIG_INPUT_PWM_VIBRA is not set=0A# CONFIG_INPUT_GPIO_ROTARY_ENCODER =
is not set=0A# CONFIG_INPUT_DA7280_HAPTICS is not set=0A# CONFIG_INPUT_AD=
XL34X is not set=0A# CONFIG_INPUT_IMS_PCU is not set=0A# CONFIG_INPUT_IQS=
269A is not set=0A# CONFIG_INPUT_IQS626A is not set=0A# CONFIG_INPUT_IQS7=
222 is not set=0A# CONFIG_INPUT_CMA3000 is not set=0A# CONFIG_INPUT_IDEAP=
AD_SLIDEBAR is not set=0A# CONFIG_INPUT_DRV260X_HAPTICS is not set=0A# CO=
NFIG_INPUT_DRV2665_HAPTICS is not set=0A# CONFIG_INPUT_DRV2667_HAPTICS is=
 not set=0A# CONFIG_RMI4_CORE is not set=0A=0A#=0A# Hardware I/O ports=0A=
#=0ACONFIG_SERIO=3Dy=0ACONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy=0ACONFIG_SERIO=
_I8042=3Dy=0A# CONFIG_SERIO_SERPORT is not set=0A# CONFIG_SERIO_CT82C710 =
is not set=0A# CONFIG_SERIO_PCIPS2 is not set=0ACONFIG_SERIO_LIBPS2=3Dy=0A=
# CONFIG_SERIO_RAW is not set=0A# CONFIG_SERIO_ALTERA_PS2 is not set=0A# =
CONFIG_SERIO_PS2MULT is not set=0A# CONFIG_SERIO_ARC_PS2 is not set=0A# C=
ONFIG_SERIO_GPIO_PS2 is not set=0A# CONFIG_USERIO is not set=0A# CONFIG_G=
AMEPORT is not set=0A# end of Hardware I/O ports=0A# end of Input device =
support=0A=0A#=0A# Character devices=0A#=0ACONFIG_TTY=3Dy=0ACONFIG_VT=3Dy=
=0ACONFIG_CONSOLE_TRANSLATIONS=3Dy=0ACONFIG_VT_CONSOLE=3Dy=0ACONFIG_VT_CO=
NSOLE_SLEEP=3Dy=0ACONFIG_HW_CONSOLE=3Dy=0ACONFIG_VT_HW_CONSOLE_BINDING=3D=
y=0ACONFIG_UNIX98_PTYS=3Dy=0A# CONFIG_LEGACY_PTYS is not set=0ACONFIG_LDI=
SC_AUTOLOAD=3Dy=0A=0A#=0A# Serial drivers=0A#=0ACONFIG_SERIAL_EARLYCON=3D=
y=0ACONFIG_SERIAL_8250=3Dy=0A# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is n=
ot set=0ACONFIG_SERIAL_8250_PNP=3Dy=0A# CONFIG_SERIAL_8250_16550A_VARIANT=
S is not set=0ACONFIG_SERIAL_8250_FINTEK=3Dy=0ACONFIG_SERIAL_8250_CONSOLE=
=3Dy=0ACONFIG_SERIAL_8250_DMA=3Dy=0ACONFIG_SERIAL_8250_PCI=3Dy=0A# CONFIG=
_SERIAL_8250_EXAR is not set=0ACONFIG_SERIAL_8250_NR_UARTS=3D32=0ACONFIG_=
SERIAL_8250_RUNTIME_UARTS=3D4=0ACONFIG_SERIAL_8250_EXTENDED=3Dy=0ACONFIG_=
SERIAL_8250_MANY_PORTS=3Dy=0ACONFIG_SERIAL_8250_SHARE_IRQ=3Dy=0A# CONFIG_=
SERIAL_8250_DETECT_IRQ is not set=0ACONFIG_SERIAL_8250_RSA=3Dy=0ACONFIG_S=
ERIAL_8250_DWLIB=3Dy=0ACONFIG_SERIAL_8250_DW=3Dy=0A# CONFIG_SERIAL_8250_R=
T288X is not set=0A# CONFIG_SERIAL_8250_LPSS is not set=0ACONFIG_SERIAL_8=
250_MID=3Dy=0ACONFIG_SERIAL_8250_PERICOM=3Dy=0A=0A#=0A# Non-8250 serial p=
ort support=0A#=0A# CONFIG_SERIAL_MAX3100 is not set=0A# CONFIG_SERIAL_MA=
X310X is not set=0A# CONFIG_SERIAL_UARTLITE is not set=0ACONFIG_SERIAL_CO=
RE=3Dy=0ACONFIG_SERIAL_CORE_CONSOLE=3Dy=0A# CONFIG_SERIAL_JSM is not set=0A=
# CONFIG_SERIAL_LANTIQ is not set=0A# CONFIG_SERIAL_SCCNXP is not set=0A#=
 CONFIG_SERIAL_SC16IS7XX is not set=0A# CONFIG_SERIAL_ALTERA_JTAGUART is =
not set=0A# CONFIG_SERIAL_ALTERA_UART is not set=0A# CONFIG_SERIAL_ARC is=
 not set=0A# CONFIG_SERIAL_RP2 is not set=0A# CONFIG_SERIAL_FSL_LPUART is=
 not set=0A# CONFIG_SERIAL_FSL_LINFLEXUART is not set=0A# CONFIG_SERIAL_S=
PRD is not set=0A# end of Serial drivers=0A=0ACONFIG_SERIAL_MCTRL_GPIO=3D=
y=0ACONFIG_SERIAL_NONSTANDARD=3Dy=0A# CONFIG_MOXA_INTELLIO is not set=0A#=
 CONFIG_MOXA_SMARTIO is not set=0A# CONFIG_SYNCLINK_GT is not set=0A# CON=
FIG_N_HDLC is not set=0A# CONFIG_N_GSM is not set=0A# CONFIG_NOZOMI is no=
t set=0A# CONFIG_NULL_TTY is not set=0ACONFIG_SERIAL_DEV_BUS=3Dy=0ACONFIG=
_SERIAL_DEV_CTRL_TTYPORT=3Dy=0A# CONFIG_TTY_PRINTK is not set=0A# CONFIG_=
VIRTIO_CONSOLE is not set=0A# CONFIG_IPMI_HANDLER is not set=0ACONFIG_HW_=
RANDOM=3Dm=0A# CONFIG_HW_RANDOM_TIMERIOMEM is not set=0A# CONFIG_HW_RANDO=
M_INTEL is not set=0A# CONFIG_HW_RANDOM_AMD is not set=0A# CONFIG_HW_RAND=
OM_BA431 is not set=0A# CONFIG_HW_RANDOM_VIA is not set=0A# CONFIG_HW_RAN=
DOM_XIPHERA is not set=0A# CONFIG_APPLICOM is not set=0A# CONFIG_MWAVE is=
 not set=0ACONFIG_DEVMEM=3Dy=0A# CONFIG_NVRAM is not set=0ACONFIG_DEVPORT=
=3Dy=0ACONFIG_HPET=3Dy=0ACONFIG_HPET_MMAP=3Dy=0ACONFIG_HPET_MMAP_DEFAULT=3D=
y=0A# CONFIG_HANGCHECK_TIMER is not set=0ACONFIG_TCG_TPM=3Dm=0ACONFIG_HW_=
RANDOM_TPM=3Dy=0ACONFIG_TCG_TIS_CORE=3Dm=0ACONFIG_TCG_TIS=3Dm=0A# CONFIG_=
TCG_TIS_SPI is not set=0A# CONFIG_TCG_TIS_I2C_CR50 is not set=0A# CONFIG_=
TCG_TIS_I2C_ATMEL is not set=0A# CONFIG_TCG_TIS_I2C_INFINEON is not set=0A=
# CONFIG_TCG_TIS_I2C_NUVOTON is not set=0A# CONFIG_TCG_NSC is not set=0A#=
 CONFIG_TCG_ATMEL is not set=0A# CONFIG_TCG_INFINEON is not set=0ACONFIG_=
TCG_CRB=3Dm=0A# CONFIG_TCG_VTPM_PROXY is not set=0A# CONFIG_TCG_TIS_ST33Z=
P24_I2C is not set=0A# CONFIG_TCG_TIS_ST33ZP24_SPI is not set=0A# CONFIG_=
TELCLOCK is not set=0A# CONFIG_XILLYBUS is not set=0A# CONFIG_XILLYUSB is=
 not set=0ACONFIG_RANDOM_TRUST_CPU=3Dy=0A# CONFIG_RANDOM_TRUST_BOOTLOADER=
 is not set=0A# end of Character devices=0A=0A#=0A# I2C support=0A#=0ACON=
FIG_I2C=3Dy=0ACONFIG_ACPI_I2C_OPREGION=3Dy=0ACONFIG_I2C_BOARDINFO=3Dy=0AC=
ONFIG_I2C_COMPAT=3Dy=0ACONFIG_I2C_CHARDEV=3Dm=0ACONFIG_I2C_MUX=3Dy=0A=0A#=
=0A# Multiplexer I2C Chip support=0A#=0A# CONFIG_I2C_MUX_GPIO is not set=0A=
# CONFIG_I2C_MUX_LTC4306 is not set=0A# CONFIG_I2C_MUX_PCA9541 is not set=
=0A# CONFIG_I2C_MUX_PCA954x is not set=0A# CONFIG_I2C_MUX_REG is not set=0A=
# CONFIG_I2C_MUX_MLXCPLD is not set=0A# end of Multiplexer I2C Chip suppo=
rt=0A=0ACONFIG_I2C_HELPER_AUTO=3Dy=0ACONFIG_I2C_SMBUS=3Dm=0ACONFIG_I2C_AL=
GOBIT=3Dm=0A=0A#=0A# I2C Hardware Bus support=0A#=0A=0A#=0A# PC SMBus hos=
t controller drivers=0A#=0A# CONFIG_I2C_ALI1535 is not set=0A# CONFIG_I2C=
_ALI1563 is not set=0A# CONFIG_I2C_ALI15X3 is not set=0A# CONFIG_I2C_AMD7=
56 is not set=0A# CONFIG_I2C_AMD8111 is not set=0A# CONFIG_I2C_AMD_MP2 is=
 not set=0ACONFIG_I2C_I801=3Dm=0A# CONFIG_I2C_ISCH is not set=0A# CONFIG_=
I2C_ISMT is not set=0A# CONFIG_I2C_PIIX4 is not set=0A# CONFIG_I2C_CHT_WC=
 is not set=0A# CONFIG_I2C_NFORCE2 is not set=0A# CONFIG_I2C_NVIDIA_GPU i=
s not set=0A# CONFIG_I2C_SIS5595 is not set=0A# CONFIG_I2C_SIS630 is not =
set=0A# CONFIG_I2C_SIS96X is not set=0A# CONFIG_I2C_VIA is not set=0A# CO=
NFIG_I2C_VIAPRO is not set=0A=0A#=0A# ACPI drivers=0A#=0A# CONFIG_I2C_SCM=
I is not set=0A=0A#=0A# I2C system bus drivers (mostly embedded / system-=
on-chip)=0A#=0A# CONFIG_I2C_CBUS_GPIO is not set=0ACONFIG_I2C_DESIGNWARE_=
CORE=3Dy=0A# CONFIG_I2C_DESIGNWARE_SLAVE is not set=0ACONFIG_I2C_DESIGNWA=
RE_PLATFORM=3Dy=0A# CONFIG_I2C_DESIGNWARE_AMDPSP is not set=0ACONFIG_I2C_=
DESIGNWARE_BAYTRAIL=3Dy=0A# CONFIG_I2C_DESIGNWARE_PCI is not set=0A# CONF=
IG_I2C_EMEV2 is not set=0A# CONFIG_I2C_GPIO is not set=0A# CONFIG_I2C_OCO=
RES is not set=0A# CONFIG_I2C_PCA_PLATFORM is not set=0A# CONFIG_I2C_SIMT=
EC is not set=0A# CONFIG_I2C_XILINX is not set=0A=0A#=0A# External I2C/SM=
Bus adapter drivers=0A#=0A# CONFIG_I2C_DIOLAN_U2C is not set=0A# CONFIG_I=
2C_CP2615 is not set=0A# CONFIG_I2C_ROBOTFUZZ_OSIF is not set=0A# CONFIG_=
I2C_TAOS_EVM is not set=0A# CONFIG_I2C_TINY_USB is not set=0A=0A#=0A# Oth=
er I2C/SMBus bus drivers=0A#=0A# CONFIG_I2C_MLXCPLD is not set=0A# CONFIG=
_I2C_VIRTIO is not set=0A# end of I2C Hardware Bus support=0A=0A# CONFIG_=
I2C_STUB is not set=0A# CONFIG_I2C_SLAVE is not set=0A# CONFIG_I2C_DEBUG_=
CORE is not set=0A# CONFIG_I2C_DEBUG_ALGO is not set=0A# CONFIG_I2C_DEBUG=
_BUS is not set=0A# end of I2C support=0A=0A# CONFIG_I3C is not set=0ACON=
FIG_SPI=3Dy=0A# CONFIG_SPI_DEBUG is not set=0ACONFIG_SPI_MASTER=3Dy=0ACON=
FIG_SPI_MEM=3Dy=0A=0A#=0A# SPI Master Controller Drivers=0A#=0A# CONFIG_S=
PI_ALTERA is not set=0A# CONFIG_SPI_AXI_SPI_ENGINE is not set=0A# CONFIG_=
SPI_BITBANG is not set=0A# CONFIG_SPI_CADENCE is not set=0A# CONFIG_SPI_D=
ESIGNWARE is not set=0A# CONFIG_SPI_NXP_FLEXSPI is not set=0A# CONFIG_SPI=
_GPIO is not set=0A# CONFIG_SPI_INTEL_PCI is not set=0A# CONFIG_SPI_INTEL=
_PLATFORM is not set=0A# CONFIG_SPI_LANTIQ_SSC is not set=0A# CONFIG_SPI_=
OC_TINY is not set=0A# CONFIG_SPI_PXA2XX is not set=0A# CONFIG_SPI_ROCKCH=
IP is not set=0A# CONFIG_SPI_SC18IS602 is not set=0A# CONFIG_SPI_SIFIVE i=
s not set=0A# CONFIG_SPI_MXIC is not set=0A# CONFIG_SPI_XCOMM is not set=0A=
# CONFIG_SPI_XILINX is not set=0A# CONFIG_SPI_ZYNQMP_GQSPI is not set=0A#=
 CONFIG_SPI_AMD is not set=0A=0A#=0A# SPI Multiplexer support=0A#=0A# CON=
FIG_SPI_MUX is not set=0A=0A#=0A# SPI Protocol Masters=0A#=0ACONFIG_SPI_S=
PIDEV=3Dy=0A# CONFIG_SPI_LOOPBACK_TEST is not set=0A# CONFIG_SPI_TLE62X0 =
is not set=0A# CONFIG_SPI_SLAVE is not set=0ACONFIG_SPI_DYNAMIC=3Dy=0A# C=
ONFIG_SPMI is not set=0A# CONFIG_HSI is not set=0ACONFIG_PPS=3Dm=0A# CONF=
IG_PPS_DEBUG is not set=0A=0A#=0A# PPS clients support=0A#=0A# CONFIG_PPS=
_CLIENT_KTIMER is not set=0A# CONFIG_PPS_CLIENT_LDISC is not set=0A# CONF=
IG_PPS_CLIENT_GPIO is not set=0A=0A#=0A# PPS generators support=0A#=0A=0A=
#=0A# PTP clock support=0A#=0ACONFIG_PTP_1588_CLOCK=3Dm=0ACONFIG_PTP_1588=
_CLOCK_OPTIONAL=3Dm=0A=0A#=0A# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING=
 to see the additional clocks.=0A#=0A# CONFIG_PTP_1588_CLOCK_IDT82P33 is =
not set=0A# CONFIG_PTP_1588_CLOCK_IDTCM is not set=0A# CONFIG_PTP_1588_CL=
OCK_VMW is not set=0A# end of PTP clock support=0A=0ACONFIG_PINCTRL=3Dy=0A=
CONFIG_PINMUX=3Dy=0ACONFIG_PINCONF=3Dy=0ACONFIG_GENERIC_PINCONF=3Dy=0A# C=
ONFIG_DEBUG_PINCTRL is not set=0ACONFIG_PINCTRL_AMD=3Dy=0A# CONFIG_PINCTR=
L_MCP23S08 is not set=0A# CONFIG_PINCTRL_SX150X is not set=0A=0A#=0A# Int=
el pinctrl drivers=0A#=0ACONFIG_PINCTRL_BAYTRAIL=3Dy=0ACONFIG_PINCTRL_CHE=
RRYVIEW=3Dy=0A# CONFIG_PINCTRL_LYNXPOINT is not set=0ACONFIG_PINCTRL_INTE=
L=3Dy=0A# CONFIG_PINCTRL_ALDERLAKE is not set=0ACONFIG_PINCTRL_BROXTON=3D=
y=0ACONFIG_PINCTRL_CANNONLAKE=3Dy=0ACONFIG_PINCTRL_CEDARFORK=3Dy=0ACONFIG=
_PINCTRL_DENVERTON=3Dy=0A# CONFIG_PINCTRL_ELKHARTLAKE is not set=0A# CONF=
IG_PINCTRL_EMMITSBURG is not set=0ACONFIG_PINCTRL_GEMINILAKE=3Dy=0ACONFIG=
_PINCTRL_ICELAKE=3Dy=0A# CONFIG_PINCTRL_JASPERLAKE is not set=0A# CONFIG_=
PINCTRL_LAKEFIELD is not set=0ACONFIG_PINCTRL_LEWISBURG=3Dy=0ACONFIG_PINC=
TRL_SUNRISEPOINT=3Dy=0A# CONFIG_PINCTRL_TIGERLAKE is not set=0A# end of I=
ntel pinctrl drivers=0A=0A#=0A# Renesas pinctrl drivers=0A#=0A# end of Re=
nesas pinctrl drivers=0A=0ACONFIG_GPIOLIB=3Dy=0ACONFIG_GPIOLIB_FASTPATH_L=
IMIT=3D512=0ACONFIG_GPIO_ACPI=3Dy=0ACONFIG_GPIOLIB_IRQCHIP=3Dy=0A# CONFIG=
_DEBUG_GPIO is not set=0ACONFIG_GPIO_SYSFS=3Dy=0ACONFIG_GPIO_CDEV=3Dy=0AC=
ONFIG_GPIO_CDEV_V1=3Dy=0A=0A#=0A# Memory mapped GPIO drivers=0A#=0A# CONF=
IG_GPIO_AMDPT is not set=0A# CONFIG_GPIO_DWAPB is not set=0A# CONFIG_GPIO=
_GENERIC_PLATFORM is not set=0A# CONFIG_GPIO_MB86S7X is not set=0A# CONFI=
G_GPIO_VX855 is not set=0A# CONFIG_GPIO_AMD_FCH is not set=0A# end of Mem=
ory mapped GPIO drivers=0A=0A#=0A# Port-mapped I/O GPIO drivers=0A#=0A# C=
ONFIG_GPIO_F7188X is not set=0A# CONFIG_GPIO_IT87 is not set=0A# CONFIG_G=
PIO_SCH311X is not set=0A# CONFIG_GPIO_WINBOND is not set=0A# CONFIG_GPIO=
_WS16C48 is not set=0A# end of Port-mapped I/O GPIO drivers=0A=0A#=0A# I2=
C GPIO expanders=0A#=0A# CONFIG_GPIO_ADP5588 is not set=0A# CONFIG_GPIO_M=
AX7300 is not set=0A# CONFIG_GPIO_MAX732X is not set=0A# CONFIG_GPIO_PCA9=
53X is not set=0A# CONFIG_GPIO_PCA9570 is not set=0A# CONFIG_GPIO_PCF857X=
 is not set=0A# CONFIG_GPIO_TPIC2810 is not set=0A# end of I2C GPIO expan=
ders=0A=0A#=0A# MFD GPIO expanders=0A#=0A# CONFIG_GPIO_CRYSTAL_COVE is no=
t set=0A# end of MFD GPIO expanders=0A=0A#=0A# PCI GPIO expanders=0A#=0A#=
 CONFIG_GPIO_AMD8111 is not set=0A# CONFIG_GPIO_BT8XX is not set=0A# CONF=
IG_GPIO_ML_IOH is not set=0A# CONFIG_GPIO_PCI_IDIO_16 is not set=0A# CONF=
IG_GPIO_PCIE_IDIO_24 is not set=0A# CONFIG_GPIO_RDC321X is not set=0A# en=
d of PCI GPIO expanders=0A=0A#=0A# SPI GPIO expanders=0A#=0A# CONFIG_GPIO=
_MAX3191X is not set=0A# CONFIG_GPIO_MAX7301 is not set=0A# CONFIG_GPIO_M=
C33880 is not set=0A# CONFIG_GPIO_PISOSR is not set=0A# CONFIG_GPIO_XRA14=
03 is not set=0A# end of SPI GPIO expanders=0A=0A#=0A# USB GPIO expanders=
=0A#=0A# end of USB GPIO expanders=0A=0A#=0A# Virtual GPIO drivers=0A#=0A=
# CONFIG_GPIO_AGGREGATOR is not set=0A# CONFIG_GPIO_MOCKUP is not set=0A#=
 CONFIG_GPIO_SIM is not set=0A# end of Virtual GPIO drivers=0A=0A# CONFIG=
_W1 is not set=0A# CONFIG_POWER_RESET is not set=0ACONFIG_POWER_SUPPLY=3D=
y=0A# CONFIG_POWER_SUPPLY_DEBUG is not set=0ACONFIG_POWER_SUPPLY_HWMON=3D=
y=0A# CONFIG_PDA_POWER is not set=0A# CONFIG_IP5XXX_POWER is not set=0A# =
CONFIG_TEST_POWER is not set=0A# CONFIG_CHARGER_ADP5061 is not set=0A# CO=
NFIG_BATTERY_CW2015 is not set=0A# CONFIG_BATTERY_DS2780 is not set=0A# C=
ONFIG_BATTERY_DS2781 is not set=0A# CONFIG_BATTERY_DS2782 is not set=0A# =
CONFIG_BATTERY_SAMSUNG_SDI is not set=0A# CONFIG_BATTERY_SBS is not set=0A=
# CONFIG_CHARGER_SBS is not set=0A# CONFIG_MANAGER_SBS is not set=0A# CON=
FIG_BATTERY_BQ27XXX is not set=0A# CONFIG_BATTERY_MAX17040 is not set=0A#=
 CONFIG_BATTERY_MAX17042 is not set=0A# CONFIG_CHARGER_MAX8903 is not set=
=0A# CONFIG_CHARGER_LP8727 is not set=0A# CONFIG_CHARGER_GPIO is not set=0A=
# CONFIG_CHARGER_MANAGER is not set=0A# CONFIG_CHARGER_LT3651 is not set=0A=
# CONFIG_CHARGER_LTC4162L is not set=0A# CONFIG_CHARGER_MAX77976 is not s=
et=0A# CONFIG_CHARGER_BQ2415X is not set=0A# CONFIG_CHARGER_BQ24257 is no=
t set=0A# CONFIG_CHARGER_BQ24735 is not set=0A# CONFIG_CHARGER_BQ2515X is=
 not set=0A# CONFIG_CHARGER_BQ25890 is not set=0A# CONFIG_CHARGER_BQ25980=
 is not set=0A# CONFIG_CHARGER_BQ256XX is not set=0A# CONFIG_CHARGER_SMB3=
47 is not set=0A# CONFIG_BATTERY_GAUGE_LTC2941 is not set=0A# CONFIG_BATT=
ERY_GOLDFISH is not set=0A# CONFIG_BATTERY_RT5033 is not set=0A# CONFIG_C=
HARGER_RT9455 is not set=0A# CONFIG_CHARGER_BD99954 is not set=0A# CONFIG=
_BATTERY_UG3105 is not set=0ACONFIG_HWMON=3Dy=0A# CONFIG_HWMON_DEBUG_CHIP=
 is not set=0A=0A#=0A# Native drivers=0A#=0A# CONFIG_SENSORS_ABITUGURU is=
 not set=0A# CONFIG_SENSORS_ABITUGURU3 is not set=0A# CONFIG_SENSORS_AD73=
14 is not set=0A# CONFIG_SENSORS_AD7414 is not set=0A# CONFIG_SENSORS_AD7=
418 is not set=0A# CONFIG_SENSORS_ADM1021 is not set=0A# CONFIG_SENSORS_A=
DM1025 is not set=0A# CONFIG_SENSORS_ADM1026 is not set=0A# CONFIG_SENSOR=
S_ADM1029 is not set=0A# CONFIG_SENSORS_ADM1031 is not set=0A# CONFIG_SEN=
SORS_ADM1177 is not set=0A# CONFIG_SENSORS_ADM9240 is not set=0A# CONFIG_=
SENSORS_ADT7310 is not set=0A# CONFIG_SENSORS_ADT7410 is not set=0A# CONF=
IG_SENSORS_ADT7411 is not set=0A# CONFIG_SENSORS_ADT7462 is not set=0A# C=
ONFIG_SENSORS_ADT7470 is not set=0A# CONFIG_SENSORS_ADT7475 is not set=0A=
# CONFIG_SENSORS_AHT10 is not set=0A# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT =
is not set=0A# CONFIG_SENSORS_AS370 is not set=0A# CONFIG_SENSORS_ASC7621=
 is not set=0A# CONFIG_SENSORS_AXI_FAN_CONTROL is not set=0A# CONFIG_SENS=
ORS_K8TEMP is not set=0A# CONFIG_SENSORS_K10TEMP is not set=0A# CONFIG_SE=
NSORS_FAM15H_POWER is not set=0A# CONFIG_SENSORS_APPLESMC is not set=0A# =
CONFIG_SENSORS_ASB100 is not set=0A# CONFIG_SENSORS_ASPEED is not set=0A#=
 CONFIG_SENSORS_ATXP1 is not set=0A# CONFIG_SENSORS_CORSAIR_CPRO is not s=
et=0A# CONFIG_SENSORS_CORSAIR_PSU is not set=0A# CONFIG_SENSORS_DRIVETEMP=
 is not set=0A# CONFIG_SENSORS_DS620 is not set=0A# CONFIG_SENSORS_DS1621=
 is not set=0A# CONFIG_SENSORS_DELL_SMM is not set=0A# CONFIG_SENSORS_I5K=
_AMB is not set=0A# CONFIG_SENSORS_F71805F is not set=0A# CONFIG_SENSORS_=
F71882FG is not set=0A# CONFIG_SENSORS_F75375S is not set=0A# CONFIG_SENS=
ORS_FSCHMD is not set=0A# CONFIG_SENSORS_FTSTEUTATES is not set=0A# CONFI=
G_SENSORS_GL518SM is not set=0A# CONFIG_SENSORS_GL520SM is not set=0A# CO=
NFIG_SENSORS_G760A is not set=0A# CONFIG_SENSORS_G762 is not set=0A# CONF=
IG_SENSORS_HIH6130 is not set=0A# CONFIG_SENSORS_I5500 is not set=0ACONFI=
G_SENSORS_CORETEMP=3Dm=0A# CONFIG_SENSORS_IT87 is not set=0A# CONFIG_SENS=
ORS_JC42 is not set=0A# CONFIG_SENSORS_POWR1220 is not set=0A# CONFIG_SEN=
SORS_LINEAGE is not set=0A# CONFIG_SENSORS_LTC2945 is not set=0A# CONFIG_=
SENSORS_LTC2947_I2C is not set=0A# CONFIG_SENSORS_LTC2947_SPI is not set=0A=
# CONFIG_SENSORS_LTC2990 is not set=0A# CONFIG_SENSORS_LTC2992 is not set=
=0A# CONFIG_SENSORS_LTC4151 is not set=0A# CONFIG_SENSORS_LTC4215 is not =
set=0A# CONFIG_SENSORS_LTC4222 is not set=0A# CONFIG_SENSORS_LTC4245 is n=
ot set=0A# CONFIG_SENSORS_LTC4260 is not set=0A# CONFIG_SENSORS_LTC4261 i=
s not set=0A# CONFIG_SENSORS_MAX1111 is not set=0A# CONFIG_SENSORS_MAX127=
 is not set=0A# CONFIG_SENSORS_MAX16065 is not set=0A# CONFIG_SENSORS_MAX=
1619 is not set=0A# CONFIG_SENSORS_MAX1668 is not set=0A# CONFIG_SENSORS_=
MAX197 is not set=0A# CONFIG_SENSORS_MAX31722 is not set=0A# CONFIG_SENSO=
RS_MAX31730 is not set=0A# CONFIG_SENSORS_MAX6620 is not set=0A# CONFIG_S=
ENSORS_MAX6621 is not set=0A# CONFIG_SENSORS_MAX6639 is not set=0A# CONFI=
G_SENSORS_MAX6642 is not set=0A# CONFIG_SENSORS_MAX6650 is not set=0A# CO=
NFIG_SENSORS_MAX6697 is not set=0A# CONFIG_SENSORS_MAX31790 is not set=0A=
# CONFIG_SENSORS_MCP3021 is not set=0A# CONFIG_SENSORS_TC654 is not set=0A=
# CONFIG_SENSORS_TPS23861 is not set=0A# CONFIG_SENSORS_MR75203 is not se=
t=0A# CONFIG_SENSORS_ADCXX is not set=0A# CONFIG_SENSORS_LM63 is not set=0A=
# CONFIG_SENSORS_LM70 is not set=0A# CONFIG_SENSORS_LM73 is not set=0A# C=
ONFIG_SENSORS_LM75 is not set=0A# CONFIG_SENSORS_LM77 is not set=0A# CONF=
IG_SENSORS_LM78 is not set=0A# CONFIG_SENSORS_LM80 is not set=0A# CONFIG_=
SENSORS_LM83 is not set=0A# CONFIG_SENSORS_LM85 is not set=0A# CONFIG_SEN=
SORS_LM87 is not set=0A# CONFIG_SENSORS_LM90 is not set=0A# CONFIG_SENSOR=
S_LM92 is not set=0A# CONFIG_SENSORS_LM93 is not set=0A# CONFIG_SENSORS_L=
M95234 is not set=0A# CONFIG_SENSORS_LM95241 is not set=0A# CONFIG_SENSOR=
S_LM95245 is not set=0A# CONFIG_SENSORS_PC87360 is not set=0A# CONFIG_SEN=
SORS_PC87427 is not set=0A# CONFIG_SENSORS_NCT6683 is not set=0A# CONFIG_=
SENSORS_NCT6775 is not set=0A# CONFIG_SENSORS_NCT6775_I2C is not set=0A# =
CONFIG_SENSORS_NCT7802 is not set=0A# CONFIG_SENSORS_NCT7904 is not set=0A=
# CONFIG_SENSORS_NPCM7XX is not set=0A# CONFIG_SENSORS_NZXT_KRAKEN2 is no=
t set=0A# CONFIG_SENSORS_NZXT_SMART2 is not set=0A# CONFIG_SENSORS_PCF859=
1 is not set=0A# CONFIG_PMBUS is not set=0A# CONFIG_SENSORS_SBTSI is not =
set=0A# CONFIG_SENSORS_SBRMI is not set=0A# CONFIG_SENSORS_SHT15 is not s=
et=0A# CONFIG_SENSORS_SHT21 is not set=0A# CONFIG_SENSORS_SHT3x is not se=
t=0A# CONFIG_SENSORS_SHT4x is not set=0A# CONFIG_SENSORS_SHTC1 is not set=
=0A# CONFIG_SENSORS_SIS5595 is not set=0A# CONFIG_SENSORS_SY7636A is not =
set=0A# CONFIG_SENSORS_DME1737 is not set=0A# CONFIG_SENSORS_EMC1403 is n=
ot set=0A# CONFIG_SENSORS_EMC2103 is not set=0A# CONFIG_SENSORS_EMC6W201 =
is not set=0A# CONFIG_SENSORS_SMSC47M1 is not set=0A# CONFIG_SENSORS_SMSC=
47M192 is not set=0A# CONFIG_SENSORS_SMSC47B397 is not set=0A# CONFIG_SEN=
SORS_SCH5627 is not set=0A# CONFIG_SENSORS_SCH5636 is not set=0A# CONFIG_=
SENSORS_STTS751 is not set=0A# CONFIG_SENSORS_SMM665 is not set=0A# CONFI=
G_SENSORS_ADC128D818 is not set=0A# CONFIG_SENSORS_ADS7828 is not set=0A#=
 CONFIG_SENSORS_ADS7871 is not set=0A# CONFIG_SENSORS_AMC6821 is not set=0A=
# CONFIG_SENSORS_INA209 is not set=0A# CONFIG_SENSORS_INA2XX is not set=0A=
# CONFIG_SENSORS_INA238 is not set=0A# CONFIG_SENSORS_INA3221 is not set=0A=
# CONFIG_SENSORS_TC74 is not set=0A# CONFIG_SENSORS_THMC50 is not set=0A#=
 CONFIG_SENSORS_TMP102 is not set=0A# CONFIG_SENSORS_TMP103 is not set=0A=
# CONFIG_SENSORS_TMP108 is not set=0A# CONFIG_SENSORS_TMP401 is not set=0A=
# CONFIG_SENSORS_TMP421 is not set=0A# CONFIG_SENSORS_TMP464 is not set=0A=
# CONFIG_SENSORS_TMP513 is not set=0A# CONFIG_SENSORS_VIA_CPUTEMP is not =
set=0A# CONFIG_SENSORS_VIA686A is not set=0A# CONFIG_SENSORS_VT1211 is no=
t set=0A# CONFIG_SENSORS_VT8231 is not set=0A# CONFIG_SENSORS_W83773G is =
not set=0A# CONFIG_SENSORS_W83781D is not set=0A# CONFIG_SENSORS_W83791D =
is not set=0A# CONFIG_SENSORS_W83792D is not set=0A# CONFIG_SENSORS_W8379=
3 is not set=0A# CONFIG_SENSORS_W83795 is not set=0A# CONFIG_SENSORS_W83L=
785TS is not set=0A# CONFIG_SENSORS_W83L786NG is not set=0A# CONFIG_SENSO=
RS_W83627HF is not set=0A# CONFIG_SENSORS_W83627EHF is not set=0A# CONFIG=
_SENSORS_XGENE is not set=0A=0A#=0A# ACPI drivers=0A#=0A# CONFIG_SENSORS_=
ACPI_POWER is not set=0A# CONFIG_SENSORS_ATK0110 is not set=0A# CONFIG_SE=
NSORS_ASUS_WMI is not set=0A# CONFIG_SENSORS_ASUS_WMI_EC is not set=0A# C=
ONFIG_SENSORS_ASUS_EC is not set=0ACONFIG_THERMAL=3Dy=0A# CONFIG_THERMAL_=
NETLINK is not set=0ACONFIG_THERMAL_STATISTICS=3Dy=0ACONFIG_THERMAL_EMERG=
ENCY_POWEROFF_DELAY_MS=3D0=0ACONFIG_THERMAL_HWMON=3Dy=0ACONFIG_THERMAL_WR=
ITABLE_TRIPS=3Dy=0ACONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy=0A# CONFIG_TH=
ERMAL_DEFAULT_GOV_FAIR_SHARE is not set=0A# CONFIG_THERMAL_DEFAULT_GOV_US=
ER_SPACE is not set=0A# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not=
 set=0ACONFIG_THERMAL_GOV_FAIR_SHARE=3Dy=0ACONFIG_THERMAL_GOV_STEP_WISE=3D=
y=0ACONFIG_THERMAL_GOV_BANG_BANG=3Dy=0ACONFIG_THERMAL_GOV_USER_SPACE=3Dy=0A=
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy=0ACONFIG_DEVFREQ_THERMAL=3Dy=0A# C=
ONFIG_THERMAL_EMULATION is not set=0A=0A#=0A# Intel thermal drivers=0A#=0A=
CONFIG_INTEL_POWERCLAMP=3Dm=0ACONFIG_X86_THERMAL_VECTOR=3Dy=0ACONFIG_X86_=
PKG_TEMP_THERMAL=3Dm=0A# CONFIG_INTEL_SOC_DTS_THERMAL is not set=0A=0A#=0A=
# ACPI INT340X thermal drivers=0A#=0A# CONFIG_INT340X_THERMAL is not set=0A=
# end of ACPI INT340X thermal drivers=0A=0A# CONFIG_INTEL_PCH_THERMAL is =
not set=0A# CONFIG_INTEL_TCC_COOLING is not set=0A# CONFIG_INTEL_MENLOW i=
s not set=0A# CONFIG_INTEL_HFI_THERMAL is not set=0A# end of Intel therma=
l drivers=0A=0ACONFIG_WATCHDOG=3Dy=0ACONFIG_WATCHDOG_CORE=3Dm=0A# CONFIG_=
WATCHDOG_NOWAYOUT is not set=0ACONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy=0A=
CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0=0ACONFIG_WATCHDOG_SYSFS=3Dy=0A# CONFIG_W=
ATCHDOG_HRTIMER_PRETIMEOUT is not set=0A=0A#=0A# Watchdog Pretimeout Gove=
rnors=0A#=0ACONFIG_WATCHDOG_PRETIMEOUT_GOV=3Dy=0ACONFIG_WATCHDOG_PRETIMEO=
UT_GOV_SEL=3Dm=0A# CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set=0ACONFI=
G_WATCHDOG_PRETIMEOUT_GOV_PANIC=3Dm=0ACONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_=
GOV_PANIC=3Dy=0A=0A#=0A# Watchdog Device Drivers=0A#=0A# CONFIG_SOFT_WATC=
HDOG is not set=0A# CONFIG_WDAT_WDT is not set=0A# CONFIG_XILINX_WATCHDOG=
 is not set=0A# CONFIG_ZIIRAVE_WATCHDOG is not set=0A# CONFIG_CADENCE_WAT=
CHDOG is not set=0A# CONFIG_DW_WATCHDOG is not set=0A# CONFIG_MAX63XX_WAT=
CHDOG is not set=0A# CONFIG_ACQUIRE_WDT is not set=0A# CONFIG_ADVANTECH_W=
DT is not set=0A# CONFIG_ALIM1535_WDT is not set=0A# CONFIG_ALIM7101_WDT =
is not set=0A# CONFIG_EBC_C384_WDT is not set=0A# CONFIG_F71808E_WDT is n=
ot set=0A# CONFIG_SP5100_TCO is not set=0A# CONFIG_SBC_FITPC2_WATCHDOG is=
 not set=0A# CONFIG_EUROTECH_WDT is not set=0A# CONFIG_IB700_WDT is not s=
et=0A# CONFIG_IBMASR is not set=0A# CONFIG_WAFER_WDT is not set=0A# CONFI=
G_I6300ESB_WDT is not set=0A# CONFIG_IE6XX_WDT is not set=0ACONFIG_ITCO_W=
DT=3Dm=0ACONFIG_ITCO_VENDOR_SUPPORT=3Dy=0A# CONFIG_IT8712F_WDT is not set=
=0A# CONFIG_IT87_WDT is not set=0A# CONFIG_HP_WATCHDOG is not set=0A# CON=
FIG_SC1200_WDT is not set=0A# CONFIG_PC87413_WDT is not set=0A# CONFIG_NV=
_TCO is not set=0A# CONFIG_60XX_WDT is not set=0A# CONFIG_CPU5_WDT is not=
 set=0A# CONFIG_SMSC_SCH311X_WDT is not set=0A# CONFIG_SMSC37B787_WDT is =
not set=0A# CONFIG_TQMX86_WDT is not set=0A# CONFIG_VIA_WDT is not set=0A=
# CONFIG_W83627HF_WDT is not set=0A# CONFIG_W83877F_WDT is not set=0A# CO=
NFIG_W83977F_WDT is not set=0A# CONFIG_MACHZ_WDT is not set=0A# CONFIG_SB=
C_EPX_C3_WATCHDOG is not set=0A# CONFIG_INTEL_MEI_WDT is not set=0A# CONF=
IG_NI903X_WDT is not set=0A# CONFIG_NIC7018_WDT is not set=0A# CONFIG_MEN=
_A21_WDT is not set=0A=0A#=0A# PCI-based Watchdog Cards=0A#=0A# CONFIG_PC=
IPCWATCHDOG is not set=0A# CONFIG_WDTPCI is not set=0A=0A#=0A# USB-based =
Watchdog Cards=0A#=0A# CONFIG_USBPCWATCHDOG is not set=0ACONFIG_SSB_POSSI=
BLE=3Dy=0A# CONFIG_SSB is not set=0ACONFIG_BCMA_POSSIBLE=3Dy=0A# CONFIG_B=
CMA is not set=0A=0A#=0A# Multifunction device drivers=0A#=0ACONFIG_MFD_C=
ORE=3Dy=0A# CONFIG_MFD_AS3711 is not set=0A# CONFIG_PMIC_ADP5520 is not s=
et=0A# CONFIG_MFD_AAT2870_CORE is not set=0A# CONFIG_MFD_BCM590XX is not =
set=0A# CONFIG_MFD_BD9571MWV is not set=0A# CONFIG_MFD_AXP20X_I2C is not =
set=0A# CONFIG_MFD_MADERA is not set=0A# CONFIG_PMIC_DA903X is not set=0A=
# CONFIG_MFD_DA9052_SPI is not set=0A# CONFIG_MFD_DA9052_I2C is not set=0A=
# CONFIG_MFD_DA9055 is not set=0A# CONFIG_MFD_DA9062 is not set=0A# CONFI=
G_MFD_DA9063 is not set=0A# CONFIG_MFD_DA9150 is not set=0A# CONFIG_MFD_D=
LN2 is not set=0A# CONFIG_MFD_MC13XXX_SPI is not set=0A# CONFIG_MFD_MC13X=
XX_I2C is not set=0A# CONFIG_MFD_MP2629 is not set=0A# CONFIG_HTC_PASIC3 =
is not set=0A# CONFIG_HTC_I2CPLD is not set=0A# CONFIG_MFD_INTEL_QUARK_I2=
C_GPIO is not set=0A# CONFIG_LPC_ICH is not set=0A# CONFIG_LPC_SCH is not=
 set=0ACONFIG_INTEL_SOC_PMIC=3Dy=0ACONFIG_INTEL_SOC_PMIC_CHTWC=3Dy=0A# CO=
NFIG_INTEL_SOC_PMIC_CHTDC_TI is not set=0ACONFIG_MFD_INTEL_LPSS=3Dm=0A# C=
ONFIG_MFD_INTEL_LPSS_ACPI is not set=0ACONFIG_MFD_INTEL_LPSS_PCI=3Dm=0A# =
CONFIG_MFD_INTEL_PMC_BXT is not set=0A# CONFIG_MFD_IQS62X is not set=0A# =
CONFIG_MFD_JANZ_CMODIO is not set=0A# CONFIG_MFD_KEMPLD is not set=0A# CO=
NFIG_MFD_88PM800 is not set=0A# CONFIG_MFD_88PM805 is not set=0A# CONFIG_=
MFD_88PM860X is not set=0A# CONFIG_MFD_MAX14577 is not set=0A# CONFIG_MFD=
_MAX77693 is not set=0A# CONFIG_MFD_MAX77843 is not set=0A# CONFIG_MFD_MA=
X8907 is not set=0A# CONFIG_MFD_MAX8925 is not set=0A# CONFIG_MFD_MAX8997=
 is not set=0A# CONFIG_MFD_MAX8998 is not set=0A# CONFIG_MFD_MT6360 is no=
t set=0A# CONFIG_MFD_MT6397 is not set=0A# CONFIG_MFD_MENF21BMC is not se=
t=0A# CONFIG_EZX_PCAP is not set=0A# CONFIG_MFD_VIPERBOARD is not set=0A#=
 CONFIG_MFD_RETU is not set=0A# CONFIG_MFD_PCF50633 is not set=0A# CONFIG=
_MFD_RDC321X is not set=0A# CONFIG_MFD_RT4831 is not set=0A# CONFIG_MFD_R=
T5033 is not set=0A# CONFIG_MFD_RC5T583 is not set=0A# CONFIG_MFD_SI476X_=
CORE is not set=0A# CONFIG_MFD_SIMPLE_MFD_I2C is not set=0A# CONFIG_MFD_S=
M501 is not set=0A# CONFIG_MFD_SKY81452 is not set=0ACONFIG_MFD_SYSCON=3D=
y=0A# CONFIG_MFD_TI_AM335X_TSCADC is not set=0A# CONFIG_MFD_LP3943 is not=
 set=0A# CONFIG_MFD_LP8788 is not set=0A# CONFIG_MFD_TI_LMU is not set=0A=
# CONFIG_MFD_PALMAS is not set=0A# CONFIG_TPS6105X is not set=0A# CONFIG_=
TPS65010 is not set=0A# CONFIG_TPS6507X is not set=0A# CONFIG_MFD_TPS6508=
6 is not set=0A# CONFIG_MFD_TPS65090 is not set=0A# CONFIG_MFD_TI_LP873X =
is not set=0A# CONFIG_MFD_TPS6586X is not set=0A# CONFIG_MFD_TPS65910 is =
not set=0A# CONFIG_MFD_TPS65912_I2C is not set=0A# CONFIG_MFD_TPS65912_SP=
I is not set=0A# CONFIG_TWL4030_CORE is not set=0A# CONFIG_TWL6040_CORE i=
s not set=0A# CONFIG_MFD_WL1273_CORE is not set=0A# CONFIG_MFD_LM3533 is =
not set=0A# CONFIG_MFD_TQMX86 is not set=0A# CONFIG_MFD_VX855 is not set=0A=
# CONFIG_MFD_ARIZONA_I2C is not set=0A# CONFIG_MFD_ARIZONA_SPI is not set=
=0A# CONFIG_MFD_WM8400 is not set=0A# CONFIG_MFD_WM831X_I2C is not set=0A=
# CONFIG_MFD_WM831X_SPI is not set=0A# CONFIG_MFD_WM8350_I2C is not set=0A=
# CONFIG_MFD_WM8994 is not set=0A# CONFIG_MFD_ATC260X_I2C is not set=0A# =
CONFIG_RAVE_SP_CORE is not set=0A# CONFIG_MFD_INTEL_M10_BMC is not set=0A=
# end of Multifunction device drivers=0A=0ACONFIG_REGULATOR=3Dy=0A# CONFI=
G_REGULATOR_DEBUG is not set=0A# CONFIG_REGULATOR_FIXED_VOLTAGE is not se=
t=0A# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set=0A# CONFIG_REGULATOR_U=
SERSPACE_CONSUMER is not set=0A# CONFIG_REGULATOR_88PG86X is not set=0A# =
CONFIG_REGULATOR_ACT8865 is not set=0A# CONFIG_REGULATOR_AD5398 is not se=
t=0A# CONFIG_REGULATOR_DA9210 is not set=0A# CONFIG_REGULATOR_DA9211 is n=
ot set=0A# CONFIG_REGULATOR_FAN53555 is not set=0A# CONFIG_REGULATOR_GPIO=
 is not set=0A# CONFIG_REGULATOR_ISL9305 is not set=0A# CONFIG_REGULATOR_=
ISL6271A is not set=0A# CONFIG_REGULATOR_LP3971 is not set=0A# CONFIG_REG=
ULATOR_LP3972 is not set=0A# CONFIG_REGULATOR_LP872X is not set=0A# CONFI=
G_REGULATOR_LP8755 is not set=0A# CONFIG_REGULATOR_LTC3589 is not set=0A#=
 CONFIG_REGULATOR_LTC3676 is not set=0A# CONFIG_REGULATOR_MAX1586 is not =
set=0A# CONFIG_REGULATOR_MAX8649 is not set=0A# CONFIG_REGULATOR_MAX8660 =
is not set=0A# CONFIG_REGULATOR_MAX8893 is not set=0A# CONFIG_REGULATOR_M=
AX8952 is not set=0A# CONFIG_REGULATOR_MAX20086 is not set=0A# CONFIG_REG=
ULATOR_MAX77826 is not set=0A# CONFIG_REGULATOR_MP8859 is not set=0A# CON=
FIG_REGULATOR_MT6311 is not set=0A# CONFIG_REGULATOR_PCA9450 is not set=0A=
# CONFIG_REGULATOR_PV88060 is not set=0A# CONFIG_REGULATOR_PV88080 is not=
 set=0A# CONFIG_REGULATOR_PV88090 is not set=0A# CONFIG_REGULATOR_PWM is =
not set=0A# CONFIG_REGULATOR_RT4801 is not set=0A# CONFIG_REGULATOR_RT519=
0A is not set=0A# CONFIG_REGULATOR_RT5759 is not set=0A# CONFIG_REGULATOR=
_RT6160 is not set=0A# CONFIG_REGULATOR_RT6245 is not set=0A# CONFIG_REGU=
LATOR_RTQ2134 is not set=0A# CONFIG_REGULATOR_RTMV20 is not set=0A# CONFI=
G_REGULATOR_RTQ6752 is not set=0A# CONFIG_REGULATOR_SLG51000 is not set=0A=
# CONFIG_REGULATOR_SY7636A is not set=0A# CONFIG_REGULATOR_TPS51632 is no=
t set=0A# CONFIG_REGULATOR_TPS62360 is not set=0A# CONFIG_REGULATOR_TPS65=
023 is not set=0A# CONFIG_REGULATOR_TPS6507X is not set=0A# CONFIG_REGULA=
TOR_TPS65132 is not set=0A# CONFIG_REGULATOR_TPS6524X is not set=0A# CONF=
IG_RC_CORE is not set=0ACONFIG_CEC_CORE=3Dm=0A=0A#=0A# CEC support=0A#=0A=
CONFIG_MEDIA_CEC_SUPPORT=3Dy=0A# CONFIG_CEC_CH7322 is not set=0A# CONFIG_=
CEC_GPIO is not set=0A# CONFIG_CEC_SECO is not set=0A# CONFIG_USB_PULSE8_=
CEC is not set=0A# CONFIG_USB_RAINSHADOW_CEC is not set=0A# end of CEC su=
pport=0A=0ACONFIG_MEDIA_SUPPORT=3Dy=0A# CONFIG_MEDIA_SUPPORT_FILTER is no=
t set=0ACONFIG_MEDIA_SUBDRV_AUTOSELECT=3Dy=0A=0A#=0A# Media device types=0A=
#=0ACONFIG_MEDIA_CAMERA_SUPPORT=3Dy=0ACONFIG_MEDIA_ANALOG_TV_SUPPORT=3Dy=0A=
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=3Dy=0ACONFIG_MEDIA_RADIO_SUPPORT=3Dy=0ACO=
NFIG_MEDIA_SDR_SUPPORT=3Dy=0ACONFIG_MEDIA_PLATFORM_SUPPORT=3Dy=0ACONFIG_M=
EDIA_TEST_SUPPORT=3Dy=0A# end of Media device types=0A=0A#=0A# Media core=
 support=0A#=0ACONFIG_VIDEO_DEV=3Dy=0A# CONFIG_MEDIA_CONTROLLER is not se=
t=0ACONFIG_DVB_CORE=3Dy=0A# end of Media core support=0A=0A#=0A# Video4Li=
nux options=0A#=0ACONFIG_VIDEO_V4L2_I2C=3Dy=0A# CONFIG_VIDEO_ADV_DEBUG is=
 not set=0A# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set=0A# end of Video4=
Linux options=0A=0A#=0A# Digital TV options=0A#=0A# CONFIG_DVB_MMAP is no=
t set=0ACONFIG_DVB_NET=3Dy=0ACONFIG_DVB_MAX_ADAPTERS=3D16=0ACONFIG_DVB_DY=
NAMIC_MINORS=3Dy=0A# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set=0A# CON=
FIG_DVB_ULE_DEBUG is not set=0A# end of Digital TV options=0A=0A#=0A# Med=
ia drivers=0A#=0A=0A#=0A# Media drivers=0A#=0A# CONFIG_MEDIA_USB_SUPPORT =
is not set=0A# CONFIG_MEDIA_PCI_SUPPORT is not set=0ACONFIG_RADIO_ADAPTER=
S=3Dy=0A# CONFIG_RADIO_MAXIRADIO is not set=0A# CONFIG_RADIO_SAA7706H is =
not set=0A# CONFIG_RADIO_SHARK is not set=0A# CONFIG_RADIO_SHARK2 is not =
set=0A# CONFIG_RADIO_SI4713 is not set=0A# CONFIG_RADIO_TEA5764 is not se=
t=0A# CONFIG_RADIO_TEF6862 is not set=0A# CONFIG_RADIO_WL1273 is not set=0A=
# CONFIG_USB_DSBR is not set=0A# CONFIG_USB_KEENE is not set=0A# CONFIG_U=
SB_MA901 is not set=0A# CONFIG_USB_MR800 is not set=0A# CONFIG_USB_RAREMO=
NO is not set=0A# CONFIG_RADIO_SI470X is not set=0ACONFIG_MEDIA_PLATFORM_=
DRIVERS=3Dy=0ACONFIG_V4L_PLATFORM_DRIVERS=3Dy=0A# CONFIG_SDR_PLATFORM_DRI=
VERS is not set=0A# CONFIG_DVB_PLATFORM_DRIVERS is not set=0A# CONFIG_V4L=
_MEM2MEM_DRIVERS is not set=0A=0A#=0A# Allegro DVT media platform drivers=
=0A#=0A=0A#=0A# Amlogic media platform drivers=0A#=0A=0A#=0A# Amphion dri=
vers=0A#=0A=0A#=0A# Aspeed media platform drivers=0A#=0A# CONFIG_VIDEO_AS=
PEED is not set=0A=0A#=0A# Atmel media platform drivers=0A#=0A=0A#=0A# Ca=
dence media platform drivers=0A#=0A# CONFIG_VIDEO_CADENCE_CSI2RX is not s=
et=0A# CONFIG_VIDEO_CADENCE_CSI2TX is not set=0A=0A#=0A# Chips&Media medi=
a platform drivers=0A#=0A=0A#=0A# Intel media platform drivers=0A#=0A=0A#=
=0A# Marvell media platform drivers=0A#=0A# CONFIG_VIDEO_CAFE_CCIC is not=
 set=0A=0A#=0A# Mediatek media platform drivers=0A#=0A=0A#=0A# NVidia med=
ia platform drivers=0A#=0A=0A#=0A# NXP media platform drivers=0A#=0A=0A#=0A=
# Qualcomm media platform drivers=0A#=0A=0A#=0A# Renesas media platform d=
rivers=0A#=0A=0A#=0A# Rockchip media platform drivers=0A#=0A=0A#=0A# Sams=
ung media platform drivers=0A#=0A=0A#=0A# STMicroelectronics media platfo=
rm drivers=0A#=0A=0A#=0A# Sunxi media platform drivers=0A#=0A=0A#=0A# Tex=
as Instruments drivers=0A#=0A=0A#=0A# VIA media platform drivers=0A#=0A=0A=
#=0A# Xilinx media platform drivers=0A#=0A=0A#=0A# MMC/SDIO DVB adapters=0A=
#=0A# CONFIG_SMS_SDIO_DRV is not set=0A# CONFIG_V4L_TEST_DRIVERS is not s=
et=0A# CONFIG_DVB_TEST_DRIVERS is not set=0A# end of Media drivers=0A=0A#=
=0A# Media ancillary drivers=0A#=0ACONFIG_MEDIA_ATTACH=3Dy=0A=0A#=0A# Cam=
era sensor devices=0A#=0A# CONFIG_VIDEO_HI556 is not set=0A# CONFIG_VIDEO=
_HI846 is not set=0A# CONFIG_VIDEO_HI847 is not set=0A# CONFIG_VIDEO_IMX2=
14 is not set=0A# CONFIG_VIDEO_IMX219 is not set=0A# CONFIG_VIDEO_IMX258 =
is not set=0A# CONFIG_VIDEO_IMX274 is not set=0A# CONFIG_VIDEO_IMX290 is =
not set=0A# CONFIG_VIDEO_IMX319 is not set=0A# CONFIG_VIDEO_IMX355 is not=
 set=0A# CONFIG_VIDEO_MT9M001 is not set=0A# CONFIG_VIDEO_MT9M032 is not =
set=0A# CONFIG_VIDEO_MT9M111 is not set=0A# CONFIG_VIDEO_MT9P031 is not s=
et=0A# CONFIG_VIDEO_MT9T001 is not set=0A# CONFIG_VIDEO_MT9T112 is not se=
t=0A# CONFIG_VIDEO_MT9V011 is not set=0A# CONFIG_VIDEO_MT9V032 is not set=
=0A# CONFIG_VIDEO_MT9V111 is not set=0A# CONFIG_VIDEO_NOON010PC30 is not =
set=0A# CONFIG_VIDEO_OG01A1B is not set=0A# CONFIG_VIDEO_OV02A10 is not s=
et=0A# CONFIG_VIDEO_OV08D10 is not set=0A# CONFIG_VIDEO_OV13858 is not se=
t=0A# CONFIG_VIDEO_OV13B10 is not set=0A# CONFIG_VIDEO_OV2640 is not set=0A=
# CONFIG_VIDEO_OV2659 is not set=0A# CONFIG_VIDEO_OV2680 is not set=0A# C=
ONFIG_VIDEO_OV2685 is not set=0A# CONFIG_VIDEO_OV2740 is not set=0A# CONF=
IG_VIDEO_OV5647 is not set=0A# CONFIG_VIDEO_OV5648 is not set=0A# CONFIG_=
VIDEO_OV5670 is not set=0A# CONFIG_VIDEO_OV5675 is not set=0A# CONFIG_VID=
EO_OV5693 is not set=0A# CONFIG_VIDEO_OV5695 is not set=0A# CONFIG_VIDEO_=
OV6650 is not set=0A# CONFIG_VIDEO_OV7251 is not set=0A# CONFIG_VIDEO_OV7=
640 is not set=0A# CONFIG_VIDEO_OV7670 is not set=0A# CONFIG_VIDEO_OV772X=
 is not set=0A# CONFIG_VIDEO_OV7740 is not set=0A# CONFIG_VIDEO_OV8856 is=
 not set=0A# CONFIG_VIDEO_OV8865 is not set=0A# CONFIG_VIDEO_OV9640 is no=
t set=0A# CONFIG_VIDEO_OV9650 is not set=0A# CONFIG_VIDEO_OV9734 is not s=
et=0A# CONFIG_VIDEO_RDACM20 is not set=0A# CONFIG_VIDEO_RDACM21 is not se=
t=0A# CONFIG_VIDEO_RJ54N1 is not set=0A# CONFIG_VIDEO_S5C73M3 is not set=0A=
# CONFIG_VIDEO_S5K4ECGX is not set=0A# CONFIG_VIDEO_S5K5BAF is not set=0A=
# CONFIG_VIDEO_S5K6A3 is not set=0A# CONFIG_VIDEO_S5K6AA is not set=0A# C=
ONFIG_VIDEO_SR030PC30 is not set=0A# CONFIG_VIDEO_VS6624 is not set=0A# C=
ONFIG_VIDEO_CCS is not set=0A# CONFIG_VIDEO_ET8EK8 is not set=0A# CONFIG_=
VIDEO_M5MOLS is not set=0A# end of Camera sensor devices=0A=0A#=0A# Lens =
drivers=0A#=0A# CONFIG_VIDEO_AD5820 is not set=0A# CONFIG_VIDEO_AK7375 is=
 not set=0A# CONFIG_VIDEO_DW9714 is not set=0A# CONFIG_VIDEO_DW9768 is no=
t set=0A# CONFIG_VIDEO_DW9807_VCM is not set=0A# end of Lens drivers=0A=0A=
#=0A# Flash devices=0A#=0A# CONFIG_VIDEO_ADP1653 is not set=0A# CONFIG_VI=
DEO_LM3560 is not set=0A# CONFIG_VIDEO_LM3646 is not set=0A# end of Flash=
 devices=0A=0A#=0A# Audio decoders, processors and mixers=0A#=0A# CONFIG_=
VIDEO_CS3308 is not set=0A# CONFIG_VIDEO_CS5345 is not set=0A# CONFIG_VID=
EO_CS53L32A is not set=0A# CONFIG_VIDEO_MSP3400 is not set=0A# CONFIG_VID=
EO_SONY_BTF_MPX is not set=0A# CONFIG_VIDEO_TDA1997X is not set=0A# CONFI=
G_VIDEO_TDA7432 is not set=0A# CONFIG_VIDEO_TDA9840 is not set=0A# CONFIG=
_VIDEO_TEA6415C is not set=0A# CONFIG_VIDEO_TEA6420 is not set=0A# CONFIG=
_VIDEO_TLV320AIC23B is not set=0A# CONFIG_VIDEO_TVAUDIO is not set=0A# CO=
NFIG_VIDEO_UDA1342 is not set=0A# CONFIG_VIDEO_VP27SMPX is not set=0A# CO=
NFIG_VIDEO_WM8739 is not set=0A# CONFIG_VIDEO_WM8775 is not set=0A# end o=
f Audio decoders, processors and mixers=0A=0A#=0A# RDS decoders=0A#=0A# C=
ONFIG_VIDEO_SAA6588 is not set=0A# end of RDS decoders=0A=0A#=0A# Video d=
ecoders=0A#=0A# CONFIG_VIDEO_ADV7180 is not set=0A# CONFIG_VIDEO_ADV7183 =
is not set=0A# CONFIG_VIDEO_ADV7604 is not set=0A# CONFIG_VIDEO_ADV7842 i=
s not set=0A# CONFIG_VIDEO_BT819 is not set=0A# CONFIG_VIDEO_BT856 is not=
 set=0A# CONFIG_VIDEO_BT866 is not set=0A# CONFIG_VIDEO_KS0127 is not set=
=0A# CONFIG_VIDEO_ML86V7667 is not set=0A# CONFIG_VIDEO_SAA7110 is not se=
t=0A# CONFIG_VIDEO_SAA711X is not set=0A# CONFIG_VIDEO_TC358743 is not se=
t=0A# CONFIG_VIDEO_TVP514X is not set=0A# CONFIG_VIDEO_TVP5150 is not set=
=0A# CONFIG_VIDEO_TVP7002 is not set=0A# CONFIG_VIDEO_TW2804 is not set=0A=
# CONFIG_VIDEO_TW9903 is not set=0A# CONFIG_VIDEO_TW9906 is not set=0A# C=
ONFIG_VIDEO_TW9910 is not set=0A# CONFIG_VIDEO_VPX3220 is not set=0A=0A#=0A=
# Video and audio decoders=0A#=0A# CONFIG_VIDEO_SAA717X is not set=0A# CO=
NFIG_VIDEO_CX25840 is not set=0A# end of Video decoders=0A=0A#=0A# Video =
encoders=0A#=0A# CONFIG_VIDEO_AD9389B is not set=0A# CONFIG_VIDEO_ADV7170=
 is not set=0A# CONFIG_VIDEO_ADV7175 is not set=0A# CONFIG_VIDEO_ADV7343 =
is not set=0A# CONFIG_VIDEO_ADV7393 is not set=0A# CONFIG_VIDEO_ADV7511 i=
s not set=0A# CONFIG_VIDEO_AK881X is not set=0A# CONFIG_VIDEO_SAA7127 is =
not set=0A# CONFIG_VIDEO_SAA7185 is not set=0A# CONFIG_VIDEO_THS8200 is n=
ot set=0A# end of Video encoders=0A=0A#=0A# Video improvement chips=0A#=0A=
# CONFIG_VIDEO_UPD64031A is not set=0A# CONFIG_VIDEO_UPD64083 is not set=0A=
# end of Video improvement chips=0A=0A#=0A# Audio/Video compression chips=
=0A#=0A# CONFIG_VIDEO_SAA6752HS is not set=0A# end of Audio/Video compres=
sion chips=0A=0A#=0A# SDR tuner chips=0A#=0A# CONFIG_SDR_MAX2175 is not s=
et=0A# end of SDR tuner chips=0A=0A#=0A# Miscellaneous helper chips=0A#=0A=
# CONFIG_VIDEO_I2C is not set=0A# CONFIG_VIDEO_M52790 is not set=0A# CONF=
IG_VIDEO_ST_MIPID02 is not set=0A# CONFIG_VIDEO_THS7303 is not set=0A# en=
d of Miscellaneous helper chips=0A=0A#=0A# Media SPI Adapters=0A#=0A# CON=
FIG_CXD2880_SPI_DRV is not set=0A# CONFIG_VIDEO_GS1662 is not set=0A# end=
 of Media SPI Adapters=0A=0ACONFIG_MEDIA_TUNER=3Dy=0A=0A#=0A# Customize T=
V tuners=0A#=0A# CONFIG_MEDIA_TUNER_E4000 is not set=0A# CONFIG_MEDIA_TUN=
ER_FC0011 is not set=0A# CONFIG_MEDIA_TUNER_FC0012 is not set=0A# CONFIG_=
MEDIA_TUNER_FC0013 is not set=0A# CONFIG_MEDIA_TUNER_FC2580 is not set=0A=
# CONFIG_MEDIA_TUNER_IT913X is not set=0A# CONFIG_MEDIA_TUNER_M88RS6000T =
is not set=0A# CONFIG_MEDIA_TUNER_MAX2165 is not set=0ACONFIG_MEDIA_TUNER=
_MC44S803=3Dy=0A# CONFIG_MEDIA_TUNER_MSI001 is not set=0A# CONFIG_MEDIA_T=
UNER_MT2060 is not set=0A# CONFIG_MEDIA_TUNER_MT2063 is not set=0ACONFIG_=
MEDIA_TUNER_MT20XX=3Dy=0A# CONFIG_MEDIA_TUNER_MT2131 is not set=0A# CONFI=
G_MEDIA_TUNER_MT2266 is not set=0A# CONFIG_MEDIA_TUNER_MXL301RF is not se=
t=0A# CONFIG_MEDIA_TUNER_MXL5005S is not set=0A# CONFIG_MEDIA_TUNER_MXL50=
07T is not set=0A# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set=0A# CONFIG_ME=
DIA_TUNER_QM1D1C0042 is not set=0A# CONFIG_MEDIA_TUNER_QT1010 is not set=0A=
# CONFIG_MEDIA_TUNER_R820T is not set=0A# CONFIG_MEDIA_TUNER_SI2157 is no=
t set=0ACONFIG_MEDIA_TUNER_SIMPLE=3Dy=0A# CONFIG_MEDIA_TUNER_TDA18212 is =
not set=0A# CONFIG_MEDIA_TUNER_TDA18218 is not set=0A# CONFIG_MEDIA_TUNER=
_TDA18250 is not set=0ACONFIG_MEDIA_TUNER_TDA18271=3Dy=0ACONFIG_MEDIA_TUN=
ER_TDA827X=3Dy=0ACONFIG_MEDIA_TUNER_TDA8290=3Dy=0ACONFIG_MEDIA_TUNER_TDA9=
887=3Dy=0ACONFIG_MEDIA_TUNER_TEA5761=3Dy=0ACONFIG_MEDIA_TUNER_TEA5767=3Dy=
=0A# CONFIG_MEDIA_TUNER_TUA9001 is not set=0ACONFIG_MEDIA_TUNER_XC2028=3D=
y=0ACONFIG_MEDIA_TUNER_XC4000=3Dy=0ACONFIG_MEDIA_TUNER_XC5000=3Dy=0A# end=
 of Customize TV tuners=0A=0A#=0A# Customise DVB Frontends=0A#=0A=0A#=0A#=
 Multistandard (satellite) frontends=0A#=0A# CONFIG_DVB_M88DS3103 is not =
set=0A# CONFIG_DVB_MXL5XX is not set=0A# CONFIG_DVB_STB0899 is not set=0A=
# CONFIG_DVB_STB6100 is not set=0A# CONFIG_DVB_STV090x is not set=0A# CON=
FIG_DVB_STV0910 is not set=0A# CONFIG_DVB_STV6110x is not set=0A# CONFIG_=
DVB_STV6111 is not set=0A=0A#=0A# Multistandard (cable + terrestrial) fro=
ntends=0A#=0A# CONFIG_DVB_DRXK is not set=0A# CONFIG_DVB_MN88472 is not s=
et=0A# CONFIG_DVB_MN88473 is not set=0A# CONFIG_DVB_SI2165 is not set=0A#=
 CONFIG_DVB_TDA18271C2DD is not set=0A=0A#=0A# DVB-S (satellite) frontend=
s=0A#=0A# CONFIG_DVB_CX24110 is not set=0A# CONFIG_DVB_CX24116 is not set=
=0A# CONFIG_DVB_CX24117 is not set=0A# CONFIG_DVB_CX24120 is not set=0A# =
CONFIG_DVB_CX24123 is not set=0A# CONFIG_DVB_DS3000 is not set=0A# CONFIG=
_DVB_MB86A16 is not set=0A# CONFIG_DVB_MT312 is not set=0A# CONFIG_DVB_S5=
H1420 is not set=0A# CONFIG_DVB_SI21XX is not set=0A# CONFIG_DVB_STB6000 =
is not set=0A# CONFIG_DVB_STV0288 is not set=0A# CONFIG_DVB_STV0299 is no=
t set=0A# CONFIG_DVB_STV0900 is not set=0A# CONFIG_DVB_STV6110 is not set=
=0A# CONFIG_DVB_TDA10071 is not set=0A# CONFIG_DVB_TDA10086 is not set=0A=
# CONFIG_DVB_TDA8083 is not set=0A# CONFIG_DVB_TDA8261 is not set=0A# CON=
FIG_DVB_TDA826X is not set=0A# CONFIG_DVB_TS2020 is not set=0A# CONFIG_DV=
B_TUA6100 is not set=0A# CONFIG_DVB_TUNER_CX24113 is not set=0A# CONFIG_D=
VB_TUNER_ITD1000 is not set=0A# CONFIG_DVB_VES1X93 is not set=0A# CONFIG_=
DVB_ZL10036 is not set=0A# CONFIG_DVB_ZL10039 is not set=0A=0A#=0A# DVB-T=
 (terrestrial) frontends=0A#=0A# CONFIG_DVB_AF9013 is not set=0A# CONFIG_=
DVB_CX22700 is not set=0A# CONFIG_DVB_CX22702 is not set=0A# CONFIG_DVB_C=
XD2820R is not set=0A# CONFIG_DVB_CXD2841ER is not set=0A# CONFIG_DVB_DIB=
3000MB is not set=0A# CONFIG_DVB_DIB3000MC is not set=0A# CONFIG_DVB_DIB7=
000M is not set=0A# CONFIG_DVB_DIB7000P is not set=0A# CONFIG_DVB_DIB9000=
 is not set=0A# CONFIG_DVB_DRXD is not set=0A# CONFIG_DVB_EC100 is not se=
t=0A# CONFIG_DVB_L64781 is not set=0A# CONFIG_DVB_MT352 is not set=0A# CO=
NFIG_DVB_NXT6000 is not set=0A# CONFIG_DVB_RTL2830 is not set=0A# CONFIG_=
DVB_RTL2832 is not set=0A# CONFIG_DVB_RTL2832_SDR is not set=0A# CONFIG_D=
VB_S5H1432 is not set=0A# CONFIG_DVB_SI2168 is not set=0A# CONFIG_DVB_SP8=
87X is not set=0A# CONFIG_DVB_STV0367 is not set=0A# CONFIG_DVB_TDA10048 =
is not set=0A# CONFIG_DVB_TDA1004X is not set=0A# CONFIG_DVB_ZD1301_DEMOD=
 is not set=0A# CONFIG_DVB_ZL10353 is not set=0A# CONFIG_DVB_CXD2880 is n=
ot set=0A=0A#=0A# DVB-C (cable) frontends=0A#=0A# CONFIG_DVB_STV0297 is n=
ot set=0A# CONFIG_DVB_TDA10021 is not set=0A# CONFIG_DVB_TDA10023 is not =
set=0A# CONFIG_DVB_VES1820 is not set=0A=0A#=0A# ATSC (North American/Kor=
ean Terrestrial/Cable DTV) frontends=0A#=0A# CONFIG_DVB_AU8522_DTV is not=
 set=0A# CONFIG_DVB_AU8522_V4L is not set=0A# CONFIG_DVB_BCM3510 is not s=
et=0A# CONFIG_DVB_LG2160 is not set=0A# CONFIG_DVB_LGDT3305 is not set=0A=
# CONFIG_DVB_LGDT3306A is not set=0A# CONFIG_DVB_LGDT330X is not set=0A# =
CONFIG_DVB_MXL692 is not set=0A# CONFIG_DVB_NXT200X is not set=0A# CONFIG=
_DVB_OR51132 is not set=0A# CONFIG_DVB_OR51211 is not set=0A# CONFIG_DVB_=
S5H1409 is not set=0A# CONFIG_DVB_S5H1411 is not set=0A=0A#=0A# ISDB-T (t=
errestrial) frontends=0A#=0A# CONFIG_DVB_DIB8000 is not set=0A# CONFIG_DV=
B_MB86A20S is not set=0A# CONFIG_DVB_S921 is not set=0A=0A#=0A# ISDB-S (s=
atellite) & ISDB-T (terrestrial) frontends=0A#=0A# CONFIG_DVB_MN88443X is=
 not set=0A# CONFIG_DVB_TC90522 is not set=0A=0A#=0A# Digital terrestrial=
 only tuners/PLL=0A#=0A# CONFIG_DVB_PLL is not set=0A# CONFIG_DVB_TUNER_D=
IB0070 is not set=0A# CONFIG_DVB_TUNER_DIB0090 is not set=0A=0A#=0A# SEC =
control devices for DVB-S=0A#=0A# CONFIG_DVB_A8293 is not set=0A# CONFIG_=
DVB_AF9033 is not set=0A# CONFIG_DVB_ASCOT2E is not set=0A# CONFIG_DVB_AT=
BM8830 is not set=0A# CONFIG_DVB_HELENE is not set=0A# CONFIG_DVB_HORUS3A=
 is not set=0A# CONFIG_DVB_ISL6405 is not set=0A# CONFIG_DVB_ISL6421 is n=
ot set=0A# CONFIG_DVB_ISL6423 is not set=0A# CONFIG_DVB_IX2505V is not se=
t=0A# CONFIG_DVB_LGS8GL5 is not set=0A# CONFIG_DVB_LGS8GXX is not set=0A#=
 CONFIG_DVB_LNBH25 is not set=0A# CONFIG_DVB_LNBH29 is not set=0A# CONFIG=
_DVB_LNBP21 is not set=0A# CONFIG_DVB_LNBP22 is not set=0A# CONFIG_DVB_M8=
8RS2000 is not set=0A# CONFIG_DVB_TDA665x is not set=0A# CONFIG_DVB_DRX39=
XYJ is not set=0A=0A#=0A# Common Interface (EN50221) controller drivers=0A=
#=0A# CONFIG_DVB_CXD2099 is not set=0A# CONFIG_DVB_SP2 is not set=0A# end=
 of Customise DVB Frontends=0A=0A#=0A# Tools to develop new frontends=0A#=
=0A# CONFIG_DVB_DUMMY_FE is not set=0A# end of Media ancillary drivers=0A=
=0A#=0A# Graphics support=0A#=0ACONFIG_AGP=3Dy=0ACONFIG_AGP_AMD64=3Dy=0AC=
ONFIG_AGP_INTEL=3Dy=0ACONFIG_AGP_SIS=3Dy=0ACONFIG_AGP_VIA=3Dy=0ACONFIG_IN=
TEL_GTT=3Dy=0ACONFIG_VGA_SWITCHEROO=3Dy=0ACONFIG_DRM=3Dm=0ACONFIG_DRM_MIP=
I_DSI=3Dy=0ACONFIG_DRM_DEBUG_SELFTEST=3Dm=0ACONFIG_DRM_KMS_HELPER=3Dm=0A#=
 CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set=0A# CONFIG_DRM_DEBUG_MO=
DESET_LOCK is not set=0ACONFIG_DRM_FBDEV_EMULATION=3Dy=0ACONFIG_DRM_FBDEV=
_OVERALLOC=3D100=0A# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set=0ACONFIG_=
DRM_LOAD_EDID_FIRMWARE=3Dy=0ACONFIG_DRM_DISPLAY_HELPER=3Dm=0ACONFIG_DRM_D=
ISPLAY_DP_HELPER=3Dy=0ACONFIG_DRM_DISPLAY_HDCP_HELPER=3Dy=0ACONFIG_DRM_DI=
SPLAY_HDMI_HELPER=3Dy=0ACONFIG_DRM_DP_AUX_CHARDEV=3Dy=0ACONFIG_DRM_DP_CEC=
=3Dy=0ACONFIG_DRM_TTM=3Dm=0ACONFIG_DRM_BUDDY=3Dm=0ACONFIG_DRM_GEM_SHMEM_H=
ELPER=3Dm=0A=0A#=0A# I2C encoder or helper chips=0A#=0A# CONFIG_DRM_I2C_C=
H7006 is not set=0A# CONFIG_DRM_I2C_SIL164 is not set=0A# CONFIG_DRM_I2C_=
NXP_TDA998X is not set=0A# CONFIG_DRM_I2C_NXP_TDA9950 is not set=0A# end =
of I2C encoder or helper chips=0A=0A#=0A# ARM devices=0A#=0A# end of ARM =
devices=0A=0A# CONFIG_DRM_RADEON is not set=0A# CONFIG_DRM_AMDGPU is not =
set=0A# CONFIG_DRM_NOUVEAU is not set=0ACONFIG_DRM_I915=3Dm=0ACONFIG_DRM_=
I915_FORCE_PROBE=3D""=0ACONFIG_DRM_I915_CAPTURE_ERROR=3Dy=0ACONFIG_DRM_I9=
15_COMPRESS_ERROR=3Dy=0ACONFIG_DRM_I915_USERPTR=3Dy=0A=0A#=0A# drm/i915 D=
ebugging=0A#=0A# CONFIG_DRM_I915_WERROR is not set=0A# CONFIG_DRM_I915_DE=
BUG is not set=0A# CONFIG_DRM_I915_DEBUG_MMIO is not set=0A# CONFIG_DRM_I=
915_SW_FENCE_DEBUG_OBJECTS is not set=0A# CONFIG_DRM_I915_SW_FENCE_CHECK_=
DAG is not set=0A# CONFIG_DRM_I915_DEBUG_GUC is not set=0A# CONFIG_DRM_I9=
15_SELFTEST is not set=0A# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not s=
et=0A# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set=0A# CONFIG_DRM_I915_=
DEBUG_RUNTIME_PM is not set=0A# end of drm/i915 Debugging=0A=0A#=0A# drm/=
i915 Profile Guided Optimisation=0A#=0ACONFIG_DRM_I915_REQUEST_TIMEOUT=3D=
20000=0ACONFIG_DRM_I915_FENCE_TIMEOUT=3D10000=0ACONFIG_DRM_I915_USERFAULT=
_AUTOSUSPEND=3D250=0ACONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500=0ACONFIG_D=
RM_I915_PREEMPT_TIMEOUT=3D640=0ACONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=3D80=
00=0ACONFIG_DRM_I915_STOP_TIMEOUT=3D100=0ACONFIG_DRM_I915_TIMESLICE_DURAT=
ION=3D1=0A# end of drm/i915 Profile Guided Optimisation=0A=0ACONFIG_DRM_V=
GEM=3Dm=0A# CONFIG_DRM_VKMS is not set=0A# CONFIG_DRM_VMWGFX is not set=0A=
# CONFIG_DRM_GMA500 is not set=0A# CONFIG_DRM_UDL is not set=0A# CONFIG_D=
RM_AST is not set=0A# CONFIG_DRM_MGAG200 is not set=0A# CONFIG_DRM_QXL is=
 not set=0A# CONFIG_DRM_VIRTIO_GPU is not set=0ACONFIG_DRM_PANEL=3Dy=0A=0A=
#=0A# Display Panels=0A#=0A# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is =
not set=0A# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set=0A# end of Displ=
ay Panels=0A=0ACONFIG_DRM_BRIDGE=3Dy=0ACONFIG_DRM_PANEL_BRIDGE=3Dy=0A=0A#=
=0A# Display Interface Bridges=0A#=0A# CONFIG_DRM_ANALOGIX_ANX78XX is not=
 set=0A# end of Display Interface Bridges=0A=0A# CONFIG_DRM_ETNAVIV is no=
t set=0A# CONFIG_DRM_BOCHS is not set=0A# CONFIG_DRM_CIRRUS_QEMU is not s=
et=0A# CONFIG_DRM_GM12U320 is not set=0A# CONFIG_DRM_PANEL_MIPI_DBI is no=
t set=0A# CONFIG_DRM_SIMPLEDRM is not set=0A# CONFIG_TINYDRM_HX8357D is n=
ot set=0A# CONFIG_TINYDRM_ILI9163 is not set=0A# CONFIG_TINYDRM_ILI9225 i=
s not set=0A# CONFIG_TINYDRM_ILI9341 is not set=0A# CONFIG_TINYDRM_ILI948=
6 is not set=0A# CONFIG_TINYDRM_MI0283QT is not set=0A# CONFIG_TINYDRM_RE=
PAPER is not set=0A# CONFIG_TINYDRM_ST7586 is not set=0A# CONFIG_TINYDRM_=
ST7735R is not set=0A# CONFIG_DRM_VBOXVIDEO is not set=0A# CONFIG_DRM_GUD=
 is not set=0A# CONFIG_DRM_SSD130X is not set=0A# CONFIG_DRM_LEGACY is no=
t set=0ACONFIG_DRM_EXPORT_FOR_TESTS=3Dy=0ACONFIG_DRM_PANEL_ORIENTATION_QU=
IRKS=3Dy=0ACONFIG_DRM_NOMODESET=3Dy=0ACONFIG_DRM_LIB_RANDOM=3Dy=0A=0A#=0A=
# Frame buffer Devices=0A#=0ACONFIG_FB_CMDLINE=3Dy=0ACONFIG_FB_NOTIFY=3Dy=
=0ACONFIG_FB=3Dy=0ACONFIG_FIRMWARE_EDID=3Dy=0ACONFIG_FB_CFB_FILLRECT=3Dy=0A=
CONFIG_FB_CFB_COPYAREA=3Dy=0ACONFIG_FB_CFB_IMAGEBLIT=3Dy=0ACONFIG_FB_SYS_=
FILLRECT=3Dm=0ACONFIG_FB_SYS_COPYAREA=3Dm=0ACONFIG_FB_SYS_IMAGEBLIT=3Dm=0A=
# CONFIG_FB_FOREIGN_ENDIAN is not set=0ACONFIG_FB_SYS_FOPS=3Dm=0ACONFIG_F=
B_DEFERRED_IO=3Dy=0ACONFIG_FB_MODE_HELPERS=3Dy=0ACONFIG_FB_TILEBLITTING=3D=
y=0A=0A#=0A# Frame buffer hardware drivers=0A#=0A# CONFIG_FB_CIRRUS is no=
t set=0A# CONFIG_FB_PM2 is not set=0A# CONFIG_FB_CYBER2000 is not set=0A#=
 CONFIG_FB_ARC is not set=0A# CONFIG_FB_ASILIANT is not set=0A# CONFIG_FB=
_IMSTT is not set=0A# CONFIG_FB_VGA16 is not set=0A# CONFIG_FB_UVESA is n=
ot set=0ACONFIG_FB_VESA=3Dy=0ACONFIG_FB_EFI=3Dy=0A# CONFIG_FB_N411 is not=
 set=0A# CONFIG_FB_HGA is not set=0A# CONFIG_FB_OPENCORES is not set=0A# =
CONFIG_FB_S1D13XXX is not set=0A# CONFIG_FB_NVIDIA is not set=0A# CONFIG_=
FB_RIVA is not set=0A# CONFIG_FB_I740 is not set=0A# CONFIG_FB_LE80578 is=
 not set=0A# CONFIG_FB_INTEL is not set=0A# CONFIG_FB_MATROX is not set=0A=
# CONFIG_FB_RADEON is not set=0A# CONFIG_FB_ATY128 is not set=0A# CONFIG_=
FB_ATY is not set=0A# CONFIG_FB_S3 is not set=0A# CONFIG_FB_SAVAGE is not=
 set=0A# CONFIG_FB_SIS is not set=0A# CONFIG_FB_VIA is not set=0A# CONFIG=
_FB_NEOMAGIC is not set=0A# CONFIG_FB_KYRO is not set=0A# CONFIG_FB_3DFX =
is not set=0A# CONFIG_FB_VOODOO1 is not set=0A# CONFIG_FB_VT8623 is not s=
et=0A# CONFIG_FB_TRIDENT is not set=0A# CONFIG_FB_ARK is not set=0A# CONF=
IG_FB_PM3 is not set=0A# CONFIG_FB_CARMINE is not set=0A# CONFIG_FB_SMSCU=
FX is not set=0A# CONFIG_FB_UDL is not set=0A# CONFIG_FB_IBM_GXT4500 is n=
ot set=0A# CONFIG_FB_VIRTUAL is not set=0A# CONFIG_FB_METRONOME is not se=
t=0A# CONFIG_FB_MB862XX is not set=0A# CONFIG_FB_SIMPLE is not set=0A# CO=
NFIG_FB_SSD1307 is not set=0A# CONFIG_FB_SM712 is not set=0A# end of Fram=
e buffer Devices=0A=0A#=0A# Backlight & LCD device support=0A#=0A# CONFIG=
_LCD_CLASS_DEVICE is not set=0ACONFIG_BACKLIGHT_CLASS_DEVICE=3Dy=0A# CONF=
IG_BACKLIGHT_KTD253 is not set=0A# CONFIG_BACKLIGHT_PWM is not set=0A# CO=
NFIG_BACKLIGHT_APPLE is not set=0A# CONFIG_BACKLIGHT_QCOM_WLED is not set=
=0A# CONFIG_BACKLIGHT_SAHARA is not set=0A# CONFIG_BACKLIGHT_ADP8860 is n=
ot set=0A# CONFIG_BACKLIGHT_ADP8870 is not set=0A# CONFIG_BACKLIGHT_LM363=
0A is not set=0A# CONFIG_BACKLIGHT_LM3639 is not set=0A# CONFIG_BACKLIGHT=
_LP855X is not set=0A# CONFIG_BACKLIGHT_GPIO is not set=0A# CONFIG_BACKLI=
GHT_LV5207LP is not set=0A# CONFIG_BACKLIGHT_BD6107 is not set=0A# CONFIG=
_BACKLIGHT_ARCXCNN is not set=0A# end of Backlight & LCD device support=0A=
=0ACONFIG_HDMI=3Dy=0A=0A#=0A# Console display driver support=0A#=0ACONFIG=
_VGA_CONSOLE=3Dy=0ACONFIG_DUMMY_CONSOLE=3Dy=0ACONFIG_DUMMY_CONSOLE_COLUMN=
S=3D80=0ACONFIG_DUMMY_CONSOLE_ROWS=3D25=0ACONFIG_FRAMEBUFFER_CONSOLE=3Dy=0A=
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set=0ACONFIG_FRAM=
EBUFFER_CONSOLE_DETECT_PRIMARY=3Dy=0ACONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3D=
y=0A# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set=0A# end of =
Console display driver support=0A=0A# CONFIG_LOGO is not set=0A# end of G=
raphics support=0A=0ACONFIG_SOUND=3Dm=0ACONFIG_SOUND_OSS_CORE=3Dy=0A# CON=
FIG_SOUND_OSS_CORE_PRECLAIM is not set=0ACONFIG_SND=3Dm=0ACONFIG_SND_TIME=
R=3Dm=0ACONFIG_SND_PCM=3Dm=0ACONFIG_SND_HWDEP=3Dm=0ACONFIG_SND_COMPRESS_O=
FFLOAD=3Dm=0ACONFIG_SND_JACK=3Dy=0ACONFIG_SND_JACK_INPUT_DEV=3Dy=0ACONFIG=
_SND_OSSEMUL=3Dy=0ACONFIG_SND_MIXER_OSS=3Dm=0ACONFIG_SND_PCM_OSS=3Dm=0ACO=
NFIG_SND_PCM_OSS_PLUGINS=3Dy=0ACONFIG_SND_PCM_TIMER=3Dy=0A# CONFIG_SND_HR=
TIMER is not set=0ACONFIG_SND_DYNAMIC_MINORS=3Dy=0ACONFIG_SND_MAX_CARDS=3D=
32=0ACONFIG_SND_SUPPORT_OLD_API=3Dy=0ACONFIG_SND_PROC_FS=3Dy=0ACONFIG_SND=
_VERBOSE_PROCFS=3Dy=0A# CONFIG_SND_VERBOSE_PRINTK is not set=0A# CONFIG_S=
ND_DEBUG is not set=0ACONFIG_SND_VMASTER=3Dy=0ACONFIG_SND_DMA_SGBUF=3Dy=0A=
# CONFIG_SND_SEQUENCER is not set=0ACONFIG_SND_DRIVERS=3Dy=0A# CONFIG_SND=
_PCSP is not set=0A# CONFIG_SND_DUMMY is not set=0A# CONFIG_SND_ALOOP is =
not set=0A# CONFIG_SND_MTPAV is not set=0A# CONFIG_SND_SERIAL_U16550 is n=
ot set=0A# CONFIG_SND_MPU401 is not set=0ACONFIG_SND_PCI=3Dy=0A# CONFIG_S=
ND_AD1889 is not set=0A# CONFIG_SND_ALS300 is not set=0A# CONFIG_SND_ALS4=
000 is not set=0A# CONFIG_SND_ALI5451 is not set=0A# CONFIG_SND_ASIHPI is=
 not set=0A# CONFIG_SND_ATIIXP is not set=0A# CONFIG_SND_ATIIXP_MODEM is =
not set=0A# CONFIG_SND_AU8810 is not set=0A# CONFIG_SND_AU8820 is not set=
=0A# CONFIG_SND_AU8830 is not set=0A# CONFIG_SND_AW2 is not set=0A# CONFI=
G_SND_AZT3328 is not set=0A# CONFIG_SND_BT87X is not set=0A# CONFIG_SND_C=
A0106 is not set=0A# CONFIG_SND_CMIPCI is not set=0A# CONFIG_SND_OXYGEN i=
s not set=0A# CONFIG_SND_CS4281 is not set=0A# CONFIG_SND_CS46XX is not s=
et=0A# CONFIG_SND_CTXFI is not set=0A# CONFIG_SND_DARLA20 is not set=0A# =
CONFIG_SND_GINA20 is not set=0A# CONFIG_SND_LAYLA20 is not set=0A# CONFIG=
_SND_DARLA24 is not set=0A# CONFIG_SND_GINA24 is not set=0A# CONFIG_SND_L=
AYLA24 is not set=0A# CONFIG_SND_MONA is not set=0A# CONFIG_SND_MIA is no=
t set=0A# CONFIG_SND_ECHO3G is not set=0A# CONFIG_SND_INDIGO is not set=0A=
# CONFIG_SND_INDIGOIO is not set=0A# CONFIG_SND_INDIGODJ is not set=0A# C=
ONFIG_SND_INDIGOIOX is not set=0A# CONFIG_SND_INDIGODJX is not set=0A# CO=
NFIG_SND_EMU10K1 is not set=0A# CONFIG_SND_EMU10K1X is not set=0A# CONFIG=
_SND_ENS1370 is not set=0A# CONFIG_SND_ENS1371 is not set=0A# CONFIG_SND_=
ES1938 is not set=0A# CONFIG_SND_ES1968 is not set=0A# CONFIG_SND_FM801 i=
s not set=0A# CONFIG_SND_HDSP is not set=0A# CONFIG_SND_HDSPM is not set=0A=
# CONFIG_SND_ICE1712 is not set=0A# CONFIG_SND_ICE1724 is not set=0A# CON=
FIG_SND_INTEL8X0 is not set=0A# CONFIG_SND_INTEL8X0M is not set=0A# CONFI=
G_SND_KORG1212 is not set=0A# CONFIG_SND_LOLA is not set=0A# CONFIG_SND_L=
X6464ES is not set=0A# CONFIG_SND_MAESTRO3 is not set=0A# CONFIG_SND_MIXA=
RT is not set=0A# CONFIG_SND_NM256 is not set=0A# CONFIG_SND_PCXHR is not=
 set=0A# CONFIG_SND_RIPTIDE is not set=0A# CONFIG_SND_RME32 is not set=0A=
# CONFIG_SND_RME96 is not set=0A# CONFIG_SND_RME9652 is not set=0A# CONFI=
G_SND_SE6X is not set=0A# CONFIG_SND_SONICVIBES is not set=0A# CONFIG_SND=
_TRIDENT is not set=0A# CONFIG_SND_VIA82XX is not set=0A# CONFIG_SND_VIA8=
2XX_MODEM is not set=0A# CONFIG_SND_VIRTUOSO is not set=0A# CONFIG_SND_VX=
222 is not set=0A# CONFIG_SND_YMFPCI is not set=0A=0A#=0A# HD-Audio=0A#=0A=
CONFIG_SND_HDA=3Dm=0ACONFIG_SND_HDA_INTEL=3Dm=0ACONFIG_SND_HDA_HWDEP=3Dy=0A=
CONFIG_SND_HDA_RECONFIG=3Dy=0ACONFIG_SND_HDA_INPUT_BEEP=3Dy=0ACONFIG_SND_=
HDA_INPUT_BEEP_MODE=3D1=0ACONFIG_SND_HDA_PATCH_LOADER=3Dy=0A# CONFIG_SND_=
HDA_SCODEC_CS35L41_I2C is not set=0A# CONFIG_SND_HDA_SCODEC_CS35L41_SPI i=
s not set=0A# CONFIG_SND_HDA_CODEC_REALTEK is not set=0A# CONFIG_SND_HDA_=
CODEC_ANALOG is not set=0A# CONFIG_SND_HDA_CODEC_SIGMATEL is not set=0A# =
CONFIG_SND_HDA_CODEC_VIA is not set=0ACONFIG_SND_HDA_CODEC_HDMI=3Dm=0A# C=
ONFIG_SND_HDA_CODEC_CIRRUS is not set=0A# CONFIG_SND_HDA_CODEC_CS8409 is =
not set=0A# CONFIG_SND_HDA_CODEC_CONEXANT is not set=0A# CONFIG_SND_HDA_C=
ODEC_CA0110 is not set=0A# CONFIG_SND_HDA_CODEC_CA0132 is not set=0A# CON=
FIG_SND_HDA_CODEC_CMEDIA is not set=0A# CONFIG_SND_HDA_CODEC_SI3054 is no=
t set=0A# CONFIG_SND_HDA_GENERIC is not set=0ACONFIG_SND_HDA_POWER_SAVE_D=
EFAULT=3D1=0A# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set=0A# end=
 of HD-Audio=0A=0ACONFIG_SND_HDA_CORE=3Dm=0ACONFIG_SND_HDA_DSP_LOADER=3Dy=
=0ACONFIG_SND_HDA_COMPONENT=3Dy=0ACONFIG_SND_HDA_I915=3Dy=0ACONFIG_SND_HD=
A_EXT_CORE=3Dm=0ACONFIG_SND_HDA_PREALLOC_SIZE=3D0=0ACONFIG_SND_INTEL_NHLT=
=3Dy=0ACONFIG_SND_INTEL_DSP_CONFIG=3Dm=0ACONFIG_SND_INTEL_SOUNDWIRE_ACPI=3D=
m=0ACONFIG_SND_SPI=3Dy=0ACONFIG_SND_USB=3Dy=0A# CONFIG_SND_USB_AUDIO is n=
ot set=0A# CONFIG_SND_USB_UA101 is not set=0A# CONFIG_SND_USB_USX2Y is no=
t set=0A# CONFIG_SND_USB_CAIAQ is not set=0A# CONFIG_SND_USB_US122L is no=
t set=0A# CONFIG_SND_USB_6FIRE is not set=0A# CONFIG_SND_USB_HIFACE is no=
t set=0A# CONFIG_SND_BCD2000 is not set=0A# CONFIG_SND_USB_POD is not set=
=0A# CONFIG_SND_USB_PODHD is not set=0A# CONFIG_SND_USB_TONEPORT is not s=
et=0A# CONFIG_SND_USB_VARIAX is not set=0ACONFIG_SND_SOC=3Dm=0ACONFIG_SND=
_SOC_COMPRESS=3Dy=0ACONFIG_SND_SOC_TOPOLOGY=3Dy=0ACONFIG_SND_SOC_ACPI=3Dm=
=0A# CONFIG_SND_SOC_ADI is not set=0A# CONFIG_SND_SOC_AMD_ACP is not set=0A=
# CONFIG_SND_SOC_AMD_ACP3x is not set=0A# CONFIG_SND_SOC_AMD_RENOIR is no=
t set=0A# CONFIG_SND_SOC_AMD_ACP5x is not set=0A# CONFIG_SND_SOC_AMD_ACP6=
x is not set=0A# CONFIG_SND_AMD_ACP_CONFIG is not set=0A# CONFIG_SND_SOC_=
AMD_ACP_COMMON is not set=0A# CONFIG_SND_ATMEL_SOC is not set=0A# CONFIG_=
SND_BCM63XX_I2S_WHISTLER is not set=0A# CONFIG_SND_DESIGNWARE_I2S is not =
set=0A=0A#=0A# SoC Audio for Freescale CPUs=0A#=0A=0A#=0A# Common SoC Aud=
io options for Freescale CPUs:=0A#=0A# CONFIG_SND_SOC_FSL_ASRC is not set=
=0A# CONFIG_SND_SOC_FSL_SAI is not set=0A# CONFIG_SND_SOC_FSL_AUDMIX is n=
ot set=0A# CONFIG_SND_SOC_FSL_SSI is not set=0A# CONFIG_SND_SOC_FSL_SPDIF=
 is not set=0A# CONFIG_SND_SOC_FSL_ESAI is not set=0A# CONFIG_SND_SOC_FSL=
_MICFIL is not set=0A# CONFIG_SND_SOC_FSL_XCVR is not set=0A# CONFIG_SND_=
SOC_IMX_AUDMUX is not set=0A# end of SoC Audio for Freescale CPUs=0A=0A# =
CONFIG_SND_I2S_HI6210_I2S is not set=0A# CONFIG_SND_SOC_IMG is not set=0A=
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=3Dy=0ACONFIG_SND_SOC_INTEL_SST=3Dm=0A# =
CONFIG_SND_SOC_INTEL_CATPT is not set=0A# CONFIG_SND_SST_ATOM_HIFI2_PLATF=
ORM_PCI is not set=0A# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI is not set=
=0A# CONFIG_SND_SOC_INTEL_SKYLAKE is not set=0A# CONFIG_SND_SOC_INTEL_SKL=
 is not set=0A# CONFIG_SND_SOC_INTEL_APL is not set=0A# CONFIG_SND_SOC_IN=
TEL_KBL is not set=0A# CONFIG_SND_SOC_INTEL_GLK is not set=0A# CONFIG_SND=
_SOC_INTEL_CNL is not set=0A# CONFIG_SND_SOC_INTEL_CFL is not set=0ACONFI=
G_SND_SOC_INTEL_CML_H=3Dm=0ACONFIG_SND_SOC_INTEL_CML_LP=3Dm=0ACONFIG_SND_=
SOC_INTEL_SKYLAKE_FAMILY=3Dm=0ACONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=
=3Dy=0ACONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=3Dm=0ACONFIG_SND_SOC_ACPI_INTE=
L_MATCH=3Dm=0A# CONFIG_SND_SOC_INTEL_AVS is not set=0ACONFIG_SND_SOC_INTE=
L_MACH=3Dy=0A# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set=0A=
# CONFIG_SND_SOC_INTEL_SOF_WM8804_MACH is not set=0A# CONFIG_SND_SOC_INTE=
L_GLK_DA7219_MAX98357A_MACH is not set=0A# CONFIG_SND_SOC_INTEL_GLK_RT568=
2_MAX98357A_MACH is not set=0A# CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_=
MACH is not set=0A# CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH is not set=0A# C=
ONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH is not set=0A# CONFIG_SND_SOC_INTEL_=
SOF_PCM512x_MACH is not set=0A# CONFIG_SND_SOC_INTEL_SOF_ES8336_MACH is n=
ot set=0A# CONFIG_SND_SOC_INTEL_SOF_NAU8825_MACH is not set=0A# CONFIG_SN=
D_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH is not set=0A# CONFIG_SND_SOC_IN=
TEL_SOF_CML_RT1011_RT5682_MACH is not set=0A# CONFIG_SND_SOC_INTEL_SOF_DA=
7219_MAX98373_MACH is not set=0A# CONFIG_SND_SOC_INTEL_SOF_SSP_AMP_MACH i=
s not set=0A# CONFIG_SND_SOC_INTEL_EHL_RT5660_MACH is not set=0A# CONFIG_=
SND_SOC_MTK_BTCVSD is not set=0ACONFIG_SND_SOC_SOF_TOPLEVEL=3Dy=0ACONFIG_=
SND_SOC_SOF_PCI_DEV=3Dm=0ACONFIG_SND_SOC_SOF_PCI=3Dm=0A# CONFIG_SND_SOC_S=
OF_ACPI is not set=0ACONFIG_SND_SOC_SOF_DEBUG_PROBES=3Dm=0ACONFIG_SND_SOC=
_SOF_CLIENT=3Dm=0A# CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set=0ACON=
FIG_SND_SOC_SOF=3Dm=0ACONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=3Dy=0A# CONFIG_=
SND_SOC_SOF_AMD_TOPLEVEL is not set=0ACONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=3D=
y=0ACONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=3Dm=0ACONFIG_SND_SOC_SOF_INTEL_A=
TOM_HIFI_EP=3Dm=0ACONFIG_SND_SOC_SOF_INTEL_COMMON=3Dm=0ACONFIG_SND_SOC_SO=
F_MERRIFIELD=3Dm=0ACONFIG_SND_SOC_SOF_INTEL_APL=3Dm=0ACONFIG_SND_SOC_SOF_=
APOLLOLAKE=3Dm=0ACONFIG_SND_SOC_SOF_GEMINILAKE=3Dm=0ACONFIG_SND_SOC_SOF_I=
NTEL_CNL=3Dm=0ACONFIG_SND_SOC_SOF_CANNONLAKE=3Dm=0ACONFIG_SND_SOC_SOF_COF=
FEELAKE=3Dm=0ACONFIG_SND_SOC_SOF_COMETLAKE=3Dm=0ACONFIG_SND_SOC_SOF_INTEL=
_ICL=3Dm=0ACONFIG_SND_SOC_SOF_ICELAKE=3Dm=0ACONFIG_SND_SOC_SOF_JASPERLAKE=
=3Dm=0ACONFIG_SND_SOC_SOF_INTEL_TGL=3Dm=0ACONFIG_SND_SOC_SOF_TIGERLAKE=3D=
m=0ACONFIG_SND_SOC_SOF_ELKHARTLAKE=3Dm=0ACONFIG_SND_SOC_SOF_ALDERLAKE=3Dm=
=0ACONFIG_SND_SOC_SOF_HDA_COMMON=3Dm=0ACONFIG_SND_SOC_SOF_HDA_LINK=3Dy=0A=
CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=3Dy=0ACONFIG_SND_SOC_SOF_HDA_LINK_BASE=
LINE=3Dm=0ACONFIG_SND_SOC_SOF_HDA=3Dm=0ACONFIG_SND_SOC_SOF_HDA_PROBES=3Dm=
=0ACONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=3Dm=0ACONFIG_SND_SOC_=
SOF_XTENSA=3Dm=0A=0A#=0A# STMicroelectronics STM32 SOC audio support=0A#=0A=
# end of STMicroelectronics STM32 SOC audio support=0A=0A# CONFIG_SND_SOC=
_XILINX_I2S is not set=0A# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not s=
et=0A# CONFIG_SND_SOC_XILINX_SPDIF is not set=0A# CONFIG_SND_SOC_XTFPGA_I=
2S is not set=0ACONFIG_SND_SOC_I2C_AND_SPI=3Dm=0A=0A#=0A# CODEC drivers=0A=
#=0A# CONFIG_SND_SOC_AC97_CODEC is not set=0A# CONFIG_SND_SOC_ADAU1372_I2=
C is not set=0A# CONFIG_SND_SOC_ADAU1372_SPI is not set=0A# CONFIG_SND_SO=
C_ADAU1701 is not set=0A# CONFIG_SND_SOC_ADAU1761_I2C is not set=0A# CONF=
IG_SND_SOC_ADAU1761_SPI is not set=0A# CONFIG_SND_SOC_ADAU7002 is not set=
=0A# CONFIG_SND_SOC_ADAU7118_HW is not set=0A# CONFIG_SND_SOC_ADAU7118_I2=
C is not set=0A# CONFIG_SND_SOC_AK4104 is not set=0A# CONFIG_SND_SOC_AK41=
18 is not set=0A# CONFIG_SND_SOC_AK4375 is not set=0A# CONFIG_SND_SOC_AK4=
458 is not set=0A# CONFIG_SND_SOC_AK4554 is not set=0A# CONFIG_SND_SOC_AK=
4613 is not set=0A# CONFIG_SND_SOC_AK4642 is not set=0A# CONFIG_SND_SOC_A=
K5386 is not set=0A# CONFIG_SND_SOC_AK5558 is not set=0A# CONFIG_SND_SOC_=
ALC5623 is not set=0A# CONFIG_SND_SOC_AW8738 is not set=0A# CONFIG_SND_SO=
C_BD28623 is not set=0A# CONFIG_SND_SOC_BT_SCO is not set=0A# CONFIG_SND_=
SOC_CS35L32 is not set=0A# CONFIG_SND_SOC_CS35L33 is not set=0A# CONFIG_S=
ND_SOC_CS35L34 is not set=0A# CONFIG_SND_SOC_CS35L35 is not set=0A# CONFI=
G_SND_SOC_CS35L36 is not set=0A# CONFIG_SND_SOC_CS35L41_SPI is not set=0A=
# CONFIG_SND_SOC_CS35L41_I2C is not set=0A# CONFIG_SND_SOC_CS35L45_SPI is=
 not set=0A# CONFIG_SND_SOC_CS35L45_I2C is not set=0A# CONFIG_SND_SOC_CS4=
2L42 is not set=0A# CONFIG_SND_SOC_CS42L51_I2C is not set=0A# CONFIG_SND_=
SOC_CS42L52 is not set=0A# CONFIG_SND_SOC_CS42L56 is not set=0A# CONFIG_S=
ND_SOC_CS42L73 is not set=0A# CONFIG_SND_SOC_CS4234 is not set=0A# CONFIG=
_SND_SOC_CS4265 is not set=0A# CONFIG_SND_SOC_CS4270 is not set=0A# CONFI=
G_SND_SOC_CS4271_I2C is not set=0A# CONFIG_SND_SOC_CS4271_SPI is not set=0A=
# CONFIG_SND_SOC_CS42XX8_I2C is not set=0A# CONFIG_SND_SOC_CS43130 is not=
 set=0A# CONFIG_SND_SOC_CS4341 is not set=0A# CONFIG_SND_SOC_CS4349 is no=
t set=0A# CONFIG_SND_SOC_CS53L30 is not set=0A# CONFIG_SND_SOC_CX2072X is=
 not set=0A# CONFIG_SND_SOC_DA7213 is not set=0A# CONFIG_SND_SOC_DMIC is =
not set=0A# CONFIG_SND_SOC_ES7134 is not set=0A# CONFIG_SND_SOC_ES7241 is=
 not set=0A# CONFIG_SND_SOC_ES8316 is not set=0A# CONFIG_SND_SOC_ES8328_I=
2C is not set=0A# CONFIG_SND_SOC_ES8328_SPI is not set=0A# CONFIG_SND_SOC=
_GTM601 is not set=0ACONFIG_SND_SOC_HDAC_HDA=3Dm=0A# CONFIG_SND_SOC_ICS43=
432 is not set=0A# CONFIG_SND_SOC_INNO_RK3036 is not set=0A# CONFIG_SND_S=
OC_MAX98088 is not set=0A# CONFIG_SND_SOC_MAX98357A is not set=0A# CONFIG=
_SND_SOC_MAX98504 is not set=0A# CONFIG_SND_SOC_MAX9867 is not set=0A# CO=
NFIG_SND_SOC_MAX98927 is not set=0A# CONFIG_SND_SOC_MAX98520 is not set=0A=
# CONFIG_SND_SOC_MAX98373_I2C is not set=0A# CONFIG_SND_SOC_MAX98390 is n=
ot set=0A# CONFIG_SND_SOC_MAX98396 is not set=0A# CONFIG_SND_SOC_MAX9860 =
is not set=0A# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set=0A# CONFIG_S=
ND_SOC_PCM1681 is not set=0A# CONFIG_SND_SOC_PCM1789_I2C is not set=0A# C=
ONFIG_SND_SOC_PCM179X_I2C is not set=0A# CONFIG_SND_SOC_PCM179X_SPI is no=
t set=0A# CONFIG_SND_SOC_PCM186X_I2C is not set=0A# CONFIG_SND_SOC_PCM186=
X_SPI is not set=0A# CONFIG_SND_SOC_PCM3060_I2C is not set=0A# CONFIG_SND=
_SOC_PCM3060_SPI is not set=0A# CONFIG_SND_SOC_PCM3168A_I2C is not set=0A=
# CONFIG_SND_SOC_PCM3168A_SPI is not set=0A# CONFIG_SND_SOC_PCM5102A is n=
ot set=0A# CONFIG_SND_SOC_PCM512x_I2C is not set=0A# CONFIG_SND_SOC_PCM51=
2x_SPI is not set=0A# CONFIG_SND_SOC_RK3328 is not set=0A# CONFIG_SND_SOC=
_RT5616 is not set=0A# CONFIG_SND_SOC_RT5631 is not set=0A# CONFIG_SND_SO=
C_RT5640 is not set=0A# CONFIG_SND_SOC_RT5659 is not set=0A# CONFIG_SND_S=
OC_RT9120 is not set=0A# CONFIG_SND_SOC_SGTL5000 is not set=0A# CONFIG_SN=
D_SOC_SIMPLE_AMPLIFIER is not set=0A# CONFIG_SND_SOC_SIMPLE_MUX is not se=
t=0A# CONFIG_SND_SOC_SPDIF is not set=0A# CONFIG_SND_SOC_SSM2305 is not s=
et=0A# CONFIG_SND_SOC_SSM2518 is not set=0A# CONFIG_SND_SOC_SSM2602_SPI i=
s not set=0A# CONFIG_SND_SOC_SSM2602_I2C is not set=0A# CONFIG_SND_SOC_SS=
M4567 is not set=0A# CONFIG_SND_SOC_STA32X is not set=0A# CONFIG_SND_SOC_=
STA350 is not set=0A# CONFIG_SND_SOC_STI_SAS is not set=0A# CONFIG_SND_SO=
C_TAS2552 is not set=0A# CONFIG_SND_SOC_TAS2562 is not set=0A# CONFIG_SND=
_SOC_TAS2764 is not set=0A# CONFIG_SND_SOC_TAS2770 is not set=0A# CONFIG_=
SND_SOC_TAS5086 is not set=0A# CONFIG_SND_SOC_TAS571X is not set=0A# CONF=
IG_SND_SOC_TAS5720 is not set=0A# CONFIG_SND_SOC_TAS5805M is not set=0A# =
CONFIG_SND_SOC_TAS6424 is not set=0A# CONFIG_SND_SOC_TDA7419 is not set=0A=
# CONFIG_SND_SOC_TFA9879 is not set=0A# CONFIG_SND_SOC_TFA989X is not set=
=0A# CONFIG_SND_SOC_TLV320ADC3XXX is not set=0A# CONFIG_SND_SOC_TLV320AIC=
23_I2C is not set=0A# CONFIG_SND_SOC_TLV320AIC23_SPI is not set=0A# CONFI=
G_SND_SOC_TLV320AIC31XX is not set=0A# CONFIG_SND_SOC_TLV320AIC32X4_I2C i=
s not set=0A# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set=0A# CONFIG_SND_=
SOC_TLV320AIC3X_I2C is not set=0A# CONFIG_SND_SOC_TLV320AIC3X_SPI is not =
set=0A# CONFIG_SND_SOC_TLV320ADCX140 is not set=0A# CONFIG_SND_SOC_TS3A22=
7E is not set=0A# CONFIG_SND_SOC_TSCS42XX is not set=0A# CONFIG_SND_SOC_T=
SCS454 is not set=0A# CONFIG_SND_SOC_UDA1334 is not set=0A# CONFIG_SND_SO=
C_WM8510 is not set=0A# CONFIG_SND_SOC_WM8523 is not set=0A# CONFIG_SND_S=
OC_WM8524 is not set=0A# CONFIG_SND_SOC_WM8580 is not set=0A# CONFIG_SND_=
SOC_WM8711 is not set=0A# CONFIG_SND_SOC_WM8728 is not set=0A# CONFIG_SND=
_SOC_WM8731_I2C is not set=0A# CONFIG_SND_SOC_WM8731_SPI is not set=0A# C=
ONFIG_SND_SOC_WM8737 is not set=0A# CONFIG_SND_SOC_WM8741 is not set=0A# =
CONFIG_SND_SOC_WM8750 is not set=0A# CONFIG_SND_SOC_WM8753 is not set=0A#=
 CONFIG_SND_SOC_WM8770 is not set=0A# CONFIG_SND_SOC_WM8776 is not set=0A=
# CONFIG_SND_SOC_WM8782 is not set=0A# CONFIG_SND_SOC_WM8804_I2C is not s=
et=0A# CONFIG_SND_SOC_WM8804_SPI is not set=0A# CONFIG_SND_SOC_WM8903 is =
not set=0A# CONFIG_SND_SOC_WM8904 is not set=0A# CONFIG_SND_SOC_WM8940 is=
 not set=0A# CONFIG_SND_SOC_WM8960 is not set=0A# CONFIG_SND_SOC_WM8962 i=
s not set=0A# CONFIG_SND_SOC_WM8974 is not set=0A# CONFIG_SND_SOC_WM8978 =
is not set=0A# CONFIG_SND_SOC_WM8985 is not set=0A# CONFIG_SND_SOC_ZL3806=
0 is not set=0A# CONFIG_SND_SOC_MAX9759 is not set=0A# CONFIG_SND_SOC_MT6=
351 is not set=0A# CONFIG_SND_SOC_MT6358 is not set=0A# CONFIG_SND_SOC_MT=
6660 is not set=0A# CONFIG_SND_SOC_NAU8315 is not set=0A# CONFIG_SND_SOC_=
NAU8540 is not set=0A# CONFIG_SND_SOC_NAU8810 is not set=0A# CONFIG_SND_S=
OC_NAU8821 is not set=0A# CONFIG_SND_SOC_NAU8822 is not set=0A# CONFIG_SN=
D_SOC_NAU8824 is not set=0A# CONFIG_SND_SOC_TPA6130A2 is not set=0A# CONF=
IG_SND_SOC_LPASS_WSA_MACRO is not set=0A# CONFIG_SND_SOC_LPASS_VA_MACRO i=
s not set=0A# CONFIG_SND_SOC_LPASS_RX_MACRO is not set=0A# CONFIG_SND_SOC=
_LPASS_TX_MACRO is not set=0A# end of CODEC drivers=0A=0A# CONFIG_SND_SIM=
PLE_CARD is not set=0ACONFIG_SND_X86=3Dy=0A# CONFIG_HDMI_LPE_AUDIO is not=
 set=0A=0A#=0A# HID support=0A#=0ACONFIG_HID=3Dm=0ACONFIG_HID_BATTERY_STR=
ENGTH=3Dy=0ACONFIG_HIDRAW=3Dy=0A# CONFIG_UHID is not set=0ACONFIG_HID_GEN=
ERIC=3Dm=0A=0A#=0A# Special HID drivers=0A#=0A# CONFIG_HID_A4TECH is not =
set=0A# CONFIG_HID_ACCUTOUCH is not set=0A# CONFIG_HID_ACRUX is not set=0A=
# CONFIG_HID_APPLE is not set=0A# CONFIG_HID_APPLEIR is not set=0A# CONFI=
G_HID_ASUS is not set=0A# CONFIG_HID_AUREAL is not set=0A# CONFIG_HID_BEL=
KIN is not set=0A# CONFIG_HID_BETOP_FF is not set=0A# CONFIG_HID_BIGBEN_F=
F is not set=0A# CONFIG_HID_CHERRY is not set=0A# CONFIG_HID_CHICONY is n=
ot set=0A# CONFIG_HID_CORSAIR is not set=0A# CONFIG_HID_COUGAR is not set=
=0A# CONFIG_HID_MACALLY is not set=0A# CONFIG_HID_PRODIKEYS is not set=0A=
# CONFIG_HID_CMEDIA is not set=0A# CONFIG_HID_CP2112 is not set=0A# CONFI=
G_HID_CREATIVE_SB0540 is not set=0A# CONFIG_HID_CYPRESS is not set=0A# CO=
NFIG_HID_DRAGONRISE is not set=0A# CONFIG_HID_EMS_FF is not set=0A# CONFI=
G_HID_ELAN is not set=0A# CONFIG_HID_ELECOM is not set=0A# CONFIG_HID_ELO=
 is not set=0A# CONFIG_HID_EZKEY is not set=0A# CONFIG_HID_FT260 is not s=
et=0A# CONFIG_HID_GEMBIRD is not set=0A# CONFIG_HID_GFRM is not set=0A# C=
ONFIG_HID_GLORIOUS is not set=0A# CONFIG_HID_HOLTEK is not set=0A# CONFIG=
_HID_VIVALDI is not set=0A# CONFIG_HID_GT683R is not set=0A# CONFIG_HID_K=
EYTOUCH is not set=0A# CONFIG_HID_KYE is not set=0A# CONFIG_HID_UCLOGIC i=
s not set=0A# CONFIG_HID_WALTOP is not set=0A# CONFIG_HID_VIEWSONIC is no=
t set=0A# CONFIG_HID_XIAOMI is not set=0A# CONFIG_HID_GYRATION is not set=
=0A# CONFIG_HID_ICADE is not set=0A# CONFIG_HID_ITE is not set=0A# CONFIG=
_HID_JABRA is not set=0A# CONFIG_HID_TWINHAN is not set=0A# CONFIG_HID_KE=
NSINGTON is not set=0A# CONFIG_HID_LCPOWER is not set=0A# CONFIG_HID_LED =
is not set=0A# CONFIG_HID_LENOVO is not set=0A# CONFIG_HID_LETSKETCH is n=
ot set=0A# CONFIG_HID_LOGITECH is not set=0A# CONFIG_HID_MAGICMOUSE is no=
t set=0A# CONFIG_HID_MALTRON is not set=0A# CONFIG_HID_MAYFLASH is not se=
t=0A# CONFIG_HID_MEGAWORLD_FF is not set=0A# CONFIG_HID_REDRAGON is not s=
et=0A# CONFIG_HID_MICROSOFT is not set=0A# CONFIG_HID_MONTEREY is not set=
=0A# CONFIG_HID_MULTITOUCH is not set=0A# CONFIG_HID_NINTENDO is not set=0A=
# CONFIG_HID_NTI is not set=0A# CONFIG_HID_NTRIG is not set=0A# CONFIG_HI=
D_ORTEK is not set=0A# CONFIG_HID_PANTHERLORD is not set=0A# CONFIG_HID_P=
ENMOUNT is not set=0A# CONFIG_HID_PETALYNX is not set=0A# CONFIG_HID_PICO=
LCD is not set=0A# CONFIG_HID_PLANTRONICS is not set=0A# CONFIG_HID_RAZER=
 is not set=0A# CONFIG_HID_PRIMAX is not set=0A# CONFIG_HID_RETRODE is no=
t set=0A# CONFIG_HID_ROCCAT is not set=0A# CONFIG_HID_SAITEK is not set=0A=
# CONFIG_HID_SAMSUNG is not set=0A# CONFIG_HID_SEMITEK is not set=0A# CON=
FIG_HID_SIGMAMICRO is not set=0A# CONFIG_HID_SONY is not set=0A# CONFIG_H=
ID_SPEEDLINK is not set=0A# CONFIG_HID_STEAM is not set=0A# CONFIG_HID_ST=
EELSERIES is not set=0A# CONFIG_HID_SUNPLUS is not set=0A# CONFIG_HID_RMI=
 is not set=0A# CONFIG_HID_GREENASIA is not set=0A# CONFIG_HID_SMARTJOYPL=
US is not set=0A# CONFIG_HID_TIVO is not set=0A# CONFIG_HID_TOPSEED is no=
t set=0A# CONFIG_HID_THINGM is not set=0A# CONFIG_HID_THRUSTMASTER is not=
 set=0A# CONFIG_HID_UDRAW_PS3 is not set=0A# CONFIG_HID_U2FZERO is not se=
t=0A# CONFIG_HID_WACOM is not set=0A# CONFIG_HID_WIIMOTE is not set=0A# C=
ONFIG_HID_XINMO is not set=0A# CONFIG_HID_ZEROPLUS is not set=0A# CONFIG_=
HID_ZYDACRON is not set=0A# CONFIG_HID_SENSOR_HUB is not set=0A# CONFIG_H=
ID_ALPS is not set=0A# CONFIG_HID_MCP2221 is not set=0A# end of Special H=
ID drivers=0A=0A#=0A# USB HID support=0A#=0ACONFIG_USB_HID=3Dm=0ACONFIG_H=
ID_PID=3Dy=0ACONFIG_USB_HIDDEV=3Dy=0A=0A#=0A# USB HID Boot Protocol drive=
rs=0A#=0A# CONFIG_USB_KBD is not set=0A# CONFIG_USB_MOUSE is not set=0A# =
end of USB HID Boot Protocol drivers=0A# end of USB HID support=0A=0A#=0A=
# I2C HID support=0A#=0A# CONFIG_I2C_HID_ACPI is not set=0A# end of I2C H=
ID support=0A=0A#=0A# Intel ISH HID support=0A#=0A# CONFIG_INTEL_ISH_HID =
is not set=0A# end of Intel ISH HID support=0A=0A#=0A# AMD SFH HID Suppor=
t=0A#=0A# CONFIG_AMD_SFH_HID is not set=0A# end of AMD SFH HID Support=0A=
# end of HID support=0A=0ACONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy=0ACONFIG_USB_=
SUPPORT=3Dy=0ACONFIG_USB_COMMON=3Dm=0ACONFIG_USB_LED_TRIG=3Dy=0A# CONFIG_=
USB_ULPI_BUS is not set=0A# CONFIG_USB_CONN_GPIO is not set=0ACONFIG_USB_=
ARCH_HAS_HCD=3Dy=0ACONFIG_USB=3Dm=0ACONFIG_USB_PCI=3Dy=0ACONFIG_USB_ANNOU=
NCE_NEW_DEVICES=3Dy=0A=0A#=0A# Miscellaneous USB options=0A#=0ACONFIG_USB=
_DEFAULT_PERSIST=3Dy=0A# CONFIG_USB_FEW_INIT_RETRIES is not set=0ACONFIG_=
USB_DYNAMIC_MINORS=3Dy=0A# CONFIG_USB_OTG is not set=0A# CONFIG_USB_OTG_P=
RODUCTLIST is not set=0A# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set=0A=
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set=0ACONFIG_USB_AUTOSUSPEND_DEL=
AY=3D2=0A# CONFIG_USB_MON is not set=0A=0A#=0A# USB Host Controller Drive=
rs=0A#=0A# CONFIG_USB_C67X00_HCD is not set=0ACONFIG_USB_XHCI_HCD=3Dm=0A#=
 CONFIG_USB_XHCI_DBGCAP is not set=0ACONFIG_USB_XHCI_PCI=3Dm=0A# CONFIG_U=
SB_XHCI_PCI_RENESAS is not set=0A# CONFIG_USB_XHCI_PLATFORM is not set=0A=
# CONFIG_USB_EHCI_HCD is not set=0A# CONFIG_USB_OXU210HP_HCD is not set=0A=
# CONFIG_USB_ISP116X_HCD is not set=0A# CONFIG_USB_FOTG210_HCD is not set=
=0A# CONFIG_USB_MAX3421_HCD is not set=0A# CONFIG_USB_OHCI_HCD is not set=
=0A# CONFIG_USB_UHCI_HCD is not set=0A# CONFIG_USB_SL811_HCD is not set=0A=
# CONFIG_USB_R8A66597_HCD is not set=0A# CONFIG_USB_HCD_TEST_MODE is not =
set=0A=0A#=0A# USB Device Class drivers=0A#=0A# CONFIG_USB_ACM is not set=
=0A# CONFIG_USB_PRINTER is not set=0A# CONFIG_USB_WDM is not set=0A# CONF=
IG_USB_TMC is not set=0A=0A#=0A# NOTE: USB_STORAGE depends on SCSI but BL=
K_DEV_SD may=0A#=0A=0A#=0A# also be needed; see USB_STORAGE Help for more=
 info=0A#=0ACONFIG_USB_STORAGE=3Dm=0A# CONFIG_USB_STORAGE_DEBUG is not se=
t=0A# CONFIG_USB_STORAGE_REALTEK is not set=0A# CONFIG_USB_STORAGE_DATAFA=
B is not set=0A# CONFIG_USB_STORAGE_FREECOM is not set=0A# CONFIG_USB_STO=
RAGE_ISD200 is not set=0A# CONFIG_USB_STORAGE_USBAT is not set=0A# CONFIG=
_USB_STORAGE_SDDR09 is not set=0A# CONFIG_USB_STORAGE_SDDR55 is not set=0A=
# CONFIG_USB_STORAGE_JUMPSHOT is not set=0A# CONFIG_USB_STORAGE_ALAUDA is=
 not set=0A# CONFIG_USB_STORAGE_ONETOUCH is not set=0A# CONFIG_USB_STORAG=
E_KARMA is not set=0A# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set=0A# CO=
NFIG_USB_STORAGE_ENE_UB6250 is not set=0A# CONFIG_USB_UAS is not set=0A=0A=
#=0A# USB Imaging devices=0A#=0A# CONFIG_USB_MDC800 is not set=0A# CONFIG=
_USB_MICROTEK is not set=0A# CONFIG_USBIP_CORE is not set=0A# CONFIG_USB_=
CDNS_SUPPORT is not set=0A# CONFIG_USB_MUSB_HDRC is not set=0A# CONFIG_US=
B_DWC3 is not set=0A# CONFIG_USB_DWC2 is not set=0A# CONFIG_USB_ISP1760 i=
s not set=0A=0A#=0A# USB port drivers=0A#=0A# CONFIG_USB_SERIAL is not se=
t=0A=0A#=0A# USB Miscellaneous drivers=0A#=0A# CONFIG_USB_EMI62 is not se=
t=0A# CONFIG_USB_EMI26 is not set=0A# CONFIG_USB_ADUTUX is not set=0A# CO=
NFIG_USB_SEVSEG is not set=0A# CONFIG_USB_LEGOTOWER is not set=0A# CONFIG=
_USB_LCD is not set=0A# CONFIG_USB_CYPRESS_CY7C63 is not set=0A# CONFIG_U=
SB_CYTHERM is not set=0A# CONFIG_USB_IDMOUSE is not set=0A# CONFIG_USB_FT=
DI_ELAN is not set=0A# CONFIG_USB_APPLEDISPLAY is not set=0A# CONFIG_APPL=
E_MFI_FASTCHARGE is not set=0A# CONFIG_USB_LD is not set=0A# CONFIG_USB_T=
RANCEVIBRATOR is not set=0A# CONFIG_USB_IOWARRIOR is not set=0A# CONFIG_U=
SB_TEST is not set=0A# CONFIG_USB_EHSET_TEST_FIXTURE is not set=0A# CONFI=
G_USB_ISIGHTFW is not set=0A# CONFIG_USB_YUREX is not set=0A# CONFIG_USB_=
EZUSB_FX2 is not set=0A# CONFIG_USB_HUB_USB251XB is not set=0A# CONFIG_US=
B_HSIC_USB3503 is not set=0A# CONFIG_USB_HSIC_USB4604 is not set=0A# CONF=
IG_USB_LINK_LAYER_TEST is not set=0A# CONFIG_USB_CHAOSKEY is not set=0A=0A=
#=0A# USB Physical Layer drivers=0A#=0A# CONFIG_NOP_USB_XCEIV is not set=0A=
# CONFIG_USB_GPIO_VBUS is not set=0A# CONFIG_USB_ISP1301 is not set=0A# e=
nd of USB Physical Layer drivers=0A=0A# CONFIG_USB_GADGET is not set=0A# =
CONFIG_TYPEC is not set=0A# CONFIG_USB_ROLE_SWITCH is not set=0ACONFIG_MM=
C=3Dm=0A# CONFIG_MMC_BLOCK is not set=0A# CONFIG_SDIO_UART is not set=0A#=
 CONFIG_MMC_TEST is not set=0A=0A#=0A# MMC/SD/SDIO Host Controller Driver=
s=0A#=0A# CONFIG_MMC_DEBUG is not set=0ACONFIG_MMC_SDHCI=3Dm=0ACONFIG_MMC=
_SDHCI_IO_ACCESSORS=3Dy=0ACONFIG_MMC_SDHCI_PCI=3Dm=0ACONFIG_MMC_RICOH_MMC=
=3Dy=0A# CONFIG_MMC_SDHCI_ACPI is not set=0A# CONFIG_MMC_SDHCI_PLTFM is n=
ot set=0A# CONFIG_MMC_WBSD is not set=0A# CONFIG_MMC_TIFM_SD is not set=0A=
# CONFIG_MMC_SPI is not set=0A# CONFIG_MMC_CB710 is not set=0A# CONFIG_MM=
C_VIA_SDMMC is not set=0A# CONFIG_MMC_VUB300 is not set=0A# CONFIG_MMC_US=
HC is not set=0A# CONFIG_MMC_USDHI6ROL0 is not set=0ACONFIG_MMC_CQHCI=3Dm=
=0A# CONFIG_MMC_HSQ is not set=0A# CONFIG_MMC_TOSHIBA_PCI is not set=0A# =
CONFIG_MMC_MTK is not set=0A# CONFIG_SCSI_UFSHCD is not set=0A# CONFIG_ME=
MSTICK is not set=0ACONFIG_NEW_LEDS=3Dy=0ACONFIG_LEDS_CLASS=3Dy=0A# CONFI=
G_LEDS_CLASS_FLASH is not set=0A# CONFIG_LEDS_CLASS_MULTICOLOR is not set=
=0ACONFIG_LEDS_BRIGHTNESS_HW_CHANGED=3Dy=0A=0A#=0A# LED drivers=0A#=0A# C=
ONFIG_LEDS_APU is not set=0A# CONFIG_LEDS_LM3530 is not set=0A# CONFIG_LE=
DS_LM3532 is not set=0A# CONFIG_LEDS_LM3642 is not set=0A# CONFIG_LEDS_PC=
A9532 is not set=0A# CONFIG_LEDS_GPIO is not set=0A# CONFIG_LEDS_LP3944 i=
s not set=0A# CONFIG_LEDS_LP3952 is not set=0A# CONFIG_LEDS_LP50XX is not=
 set=0A# CONFIG_LEDS_CLEVO_MAIL is not set=0A# CONFIG_LEDS_PCA955X is not=
 set=0A# CONFIG_LEDS_PCA963X is not set=0A# CONFIG_LEDS_DAC124S085 is not=
 set=0A# CONFIG_LEDS_PWM is not set=0A# CONFIG_LEDS_REGULATOR is not set=0A=
# CONFIG_LEDS_BD2802 is not set=0A# CONFIG_LEDS_INTEL_SS4200 is not set=0A=
# CONFIG_LEDS_LT3593 is not set=0A# CONFIG_LEDS_TCA6507 is not set=0A# CO=
NFIG_LEDS_TLC591XX is not set=0A# CONFIG_LEDS_LM355x is not set=0A=0A#=0A=
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_T=
HINGM)=0A#=0A# CONFIG_LEDS_BLINKM is not set=0A# CONFIG_LEDS_MLXCPLD is n=
ot set=0A# CONFIG_LEDS_MLXREG is not set=0A# CONFIG_LEDS_USER is not set=0A=
# CONFIG_LEDS_NIC78BX is not set=0A# CONFIG_LEDS_TI_LMU_COMMON is not set=
=0A=0A#=0A# Flash and Torch LED drivers=0A#=0A=0A#=0A# RGB LED drivers=0A=
#=0A=0A#=0A# LED Triggers=0A#=0ACONFIG_LEDS_TRIGGERS=3Dy=0A# CONFIG_LEDS_=
TRIGGER_TIMER is not set=0A# CONFIG_LEDS_TRIGGER_ONESHOT is not set=0ACON=
FIG_LEDS_TRIGGER_DISK=3Dy=0A# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set=0A=
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set=0A# CONFIG_LEDS_TRIGGER_ACTIVI=
TY is not set=0A# CONFIG_LEDS_TRIGGER_GPIO is not set=0A# CONFIG_LEDS_TRI=
GGER_DEFAULT_ON is not set=0A=0A#=0A# iptables trigger is under Netfilter=
 config (LED target)=0A#=0A# CONFIG_LEDS_TRIGGER_TRANSIENT is not set=0A#=
 CONFIG_LEDS_TRIGGER_CAMERA is not set=0ACONFIG_LEDS_TRIGGER_PANIC=3Dy=0A=
# CONFIG_LEDS_TRIGGER_NETDEV is not set=0A# CONFIG_LEDS_TRIGGER_PATTERN i=
s not set=0A# CONFIG_LEDS_TRIGGER_AUDIO is not set=0A# CONFIG_LEDS_TRIGGE=
R_TTY is not set=0A=0A#=0A# Simple LED drivers=0A#=0ACONFIG_ACCESSIBILITY=
=3Dy=0ACONFIG_A11Y_BRAILLE_CONSOLE=3Dy=0A=0A#=0A# Speakup console speech=0A=
#=0A# CONFIG_SPEAKUP is not set=0A# end of Speakup console speech=0A=0A# =
CONFIG_INFINIBAND is not set=0ACONFIG_EDAC_ATOMIC_SCRUB=3Dy=0ACONFIG_EDAC=
_SUPPORT=3Dy=0ACONFIG_EDAC=3Dy=0ACONFIG_EDAC_LEGACY_SYSFS=3Dy=0A# CONFIG_=
EDAC_DEBUG is not set=0A# CONFIG_EDAC_DECODE_MCE is not set=0A# CONFIG_ED=
AC_GHES is not set=0A# CONFIG_EDAC_E752X is not set=0A# CONFIG_EDAC_I8297=
5X is not set=0A# CONFIG_EDAC_I3000 is not set=0A# CONFIG_EDAC_I3200 is n=
ot set=0A# CONFIG_EDAC_IE31200 is not set=0A# CONFIG_EDAC_X38 is not set=0A=
# CONFIG_EDAC_I5400 is not set=0A# CONFIG_EDAC_I7CORE is not set=0A# CONF=
IG_EDAC_I5000 is not set=0A# CONFIG_EDAC_I5100 is not set=0A# CONFIG_EDAC=
_I7300 is not set=0A# CONFIG_EDAC_SBRIDGE is not set=0A# CONFIG_EDAC_SKX =
is not set=0A# CONFIG_EDAC_I10NM is not set=0A# CONFIG_EDAC_PND2 is not s=
et=0A# CONFIG_EDAC_IGEN6 is not set=0ACONFIG_RTC_LIB=3Dy=0ACONFIG_RTC_MC1=
46818_LIB=3Dy=0ACONFIG_RTC_CLASS=3Dy=0ACONFIG_RTC_HCTOSYS=3Dy=0ACONFIG_RT=
C_HCTOSYS_DEVICE=3D"rtc0"=0ACONFIG_RTC_SYSTOHC=3Dy=0ACONFIG_RTC_SYSTOHC_D=
EVICE=3D"rtc0"=0A# CONFIG_RTC_DEBUG is not set=0ACONFIG_RTC_NVMEM=3Dy=0A=0A=
#=0A# RTC interfaces=0A#=0ACONFIG_RTC_INTF_SYSFS=3Dy=0ACONFIG_RTC_INTF_PR=
OC=3Dy=0ACONFIG_RTC_INTF_DEV=3Dy=0A# CONFIG_RTC_INTF_DEV_UIE_EMUL is not =
set=0A# CONFIG_RTC_DRV_TEST is not set=0A=0A#=0A# I2C RTC drivers=0A#=0A#=
 CONFIG_RTC_DRV_ABB5ZES3 is not set=0A# CONFIG_RTC_DRV_ABEOZ9 is not set=0A=
# CONFIG_RTC_DRV_ABX80X is not set=0A# CONFIG_RTC_DRV_DS1307 is not set=0A=
# CONFIG_RTC_DRV_DS1374 is not set=0A# CONFIG_RTC_DRV_DS1672 is not set=0A=
# CONFIG_RTC_DRV_MAX6900 is not set=0A# CONFIG_RTC_DRV_RS5C372 is not set=
=0A# CONFIG_RTC_DRV_ISL1208 is not set=0A# CONFIG_RTC_DRV_ISL12022 is not=
 set=0A# CONFIG_RTC_DRV_X1205 is not set=0A# CONFIG_RTC_DRV_PCF8523 is no=
t set=0A# CONFIG_RTC_DRV_PCF85063 is not set=0A# CONFIG_RTC_DRV_PCF85363 =
is not set=0A# CONFIG_RTC_DRV_PCF8563 is not set=0A# CONFIG_RTC_DRV_PCF85=
83 is not set=0A# CONFIG_RTC_DRV_M41T80 is not set=0A# CONFIG_RTC_DRV_BQ3=
2K is not set=0A# CONFIG_RTC_DRV_S35390A is not set=0A# CONFIG_RTC_DRV_FM=
3130 is not set=0A# CONFIG_RTC_DRV_RX8010 is not set=0A# CONFIG_RTC_DRV_R=
X8581 is not set=0A# CONFIG_RTC_DRV_RX8025 is not set=0A# CONFIG_RTC_DRV_=
EM3027 is not set=0A# CONFIG_RTC_DRV_RV3028 is not set=0A# CONFIG_RTC_DRV=
_RV3032 is not set=0A# CONFIG_RTC_DRV_RV8803 is not set=0A# CONFIG_RTC_DR=
V_SD3078 is not set=0A=0A#=0A# SPI RTC drivers=0A#=0A# CONFIG_RTC_DRV_M41=
T93 is not set=0A# CONFIG_RTC_DRV_M41T94 is not set=0A# CONFIG_RTC_DRV_DS=
1302 is not set=0A# CONFIG_RTC_DRV_DS1305 is not set=0A# CONFIG_RTC_DRV_D=
S1343 is not set=0A# CONFIG_RTC_DRV_DS1347 is not set=0A# CONFIG_RTC_DRV_=
DS1390 is not set=0A# CONFIG_RTC_DRV_MAX6916 is not set=0A# CONFIG_RTC_DR=
V_R9701 is not set=0A# CONFIG_RTC_DRV_RX4581 is not set=0A# CONFIG_RTC_DR=
V_RS5C348 is not set=0A# CONFIG_RTC_DRV_MAX6902 is not set=0A# CONFIG_RTC=
_DRV_PCF2123 is not set=0A# CONFIG_RTC_DRV_MCP795 is not set=0ACONFIG_RTC=
_I2C_AND_SPI=3Dy=0A=0A#=0A# SPI and I2C RTC drivers=0A#=0A# CONFIG_RTC_DR=
V_DS3232 is not set=0A# CONFIG_RTC_DRV_PCF2127 is not set=0A# CONFIG_RTC_=
DRV_RV3029C2 is not set=0A# CONFIG_RTC_DRV_RX6110 is not set=0A=0A#=0A# P=
latform RTC drivers=0A#=0ACONFIG_RTC_DRV_CMOS=3Dy=0A# CONFIG_RTC_DRV_DS12=
86 is not set=0A# CONFIG_RTC_DRV_DS1511 is not set=0A# CONFIG_RTC_DRV_DS1=
553 is not set=0A# CONFIG_RTC_DRV_DS1685_FAMILY is not set=0A# CONFIG_RTC=
_DRV_DS1742 is not set=0A# CONFIG_RTC_DRV_DS2404 is not set=0A# CONFIG_RT=
C_DRV_STK17TA8 is not set=0A# CONFIG_RTC_DRV_M48T86 is not set=0A# CONFIG=
_RTC_DRV_M48T35 is not set=0A# CONFIG_RTC_DRV_M48T59 is not set=0A# CONFI=
G_RTC_DRV_MSM6242 is not set=0A# CONFIG_RTC_DRV_BQ4802 is not set=0A# CON=
FIG_RTC_DRV_RP5C01 is not set=0A# CONFIG_RTC_DRV_V3020 is not set=0A=0A#=0A=
# on-CPU RTC drivers=0A#=0A# CONFIG_RTC_DRV_FTRTC010 is not set=0A=0A#=0A=
# HID Sensor RTC drivers=0A#=0A# CONFIG_RTC_DRV_GOLDFISH is not set=0ACON=
FIG_DMADEVICES=3Dy=0A# CONFIG_DMADEVICES_DEBUG is not set=0A=0A#=0A# DMA =
Devices=0A#=0ACONFIG_DMA_ENGINE=3Dy=0ACONFIG_DMA_VIRTUAL_CHANNELS=3Dy=0AC=
ONFIG_DMA_ACPI=3Dy=0A# CONFIG_ALTERA_MSGDMA is not set=0ACONFIG_INTEL_IDM=
A64=3Dm=0A# CONFIG_INTEL_IDXD is not set=0A# CONFIG_INTEL_IDXD_COMPAT is =
not set=0A# CONFIG_INTEL_IOATDMA is not set=0A# CONFIG_PLX_DMA is not set=
=0A# CONFIG_AMD_PTDMA is not set=0A# CONFIG_QCOM_HIDMA_MGMT is not set=0A=
# CONFIG_QCOM_HIDMA is not set=0A# CONFIG_DW_DMAC is not set=0A# CONFIG_D=
W_DMAC_PCI is not set=0A# CONFIG_DW_EDMA is not set=0A# CONFIG_DW_EDMA_PC=
IE is not set=0ACONFIG_HSU_DMA=3Dy=0A# CONFIG_SF_PDMA is not set=0A# CONF=
IG_INTEL_LDMA is not set=0A=0A#=0A# DMA Clients=0A#=0ACONFIG_ASYNC_TX_DMA=
=3Dy=0A# CONFIG_DMATEST is not set=0A=0A#=0A# DMABUF options=0A#=0ACONFIG=
_SYNC_FILE=3Dy=0ACONFIG_SW_SYNC=3Dy=0A# CONFIG_UDMABUF is not set=0A# CON=
FIG_DMABUF_MOVE_NOTIFY is not set=0A# CONFIG_DMABUF_DEBUG is not set=0ACO=
NFIG_DMABUF_SELFTESTS=3Dm=0A# CONFIG_DMABUF_HEAPS is not set=0A# CONFIG_D=
MABUF_SYSFS_STATS is not set=0A# end of DMABUF options=0A=0A# CONFIG_AUXD=
ISPLAY is not set=0ACONFIG_UIO=3Dm=0A# CONFIG_UIO_CIF is not set=0A# CONF=
IG_UIO_PDRV_GENIRQ is not set=0ACONFIG_UIO_DMEM_GENIRQ=3Dm=0A# CONFIG_UIO=
_AEC is not set=0A# CONFIG_UIO_SERCOS3 is not set=0A# CONFIG_UIO_PCI_GENE=
RIC is not set=0A# CONFIG_UIO_NETX is not set=0A# CONFIG_UIO_PRUSS is not=
 set=0A# CONFIG_UIO_MF624 is not set=0A# CONFIG_VFIO is not set=0ACONFIG_=
VIRT_DRIVERS=3Dy=0ACONFIG_VMGENID=3Dy=0A# CONFIG_VBOXGUEST is not set=0A#=
 CONFIG_NITRO_ENCLAVES is not set=0A# CONFIG_EFI_SECRET is not set=0ACONF=
IG_VIRTIO_MENU=3Dy=0A# CONFIG_VIRTIO_HARDEN_NOTIFICATION is not set=0A# C=
ONFIG_VIRTIO_PCI is not set=0A# CONFIG_VIRTIO_MMIO is not set=0A# CONFIG_=
VDPA is not set=0ACONFIG_VHOST_MENU=3Dy=0A# CONFIG_VHOST_NET is not set=0A=
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set=0A=0A#=0A# Microsoft Hyper-=
V guest support=0A#=0A# CONFIG_HYPERV is not set=0A# end of Microsoft Hyp=
er-V guest support=0A=0A# CONFIG_GREYBUS is not set=0A# CONFIG_COMEDI is =
not set=0ACONFIG_STAGING=3Dy=0A# CONFIG_PRISM2_USB is not set=0A# CONFIG_=
RTL8192U is not set=0A# CONFIG_RTLLIB is not set=0A# CONFIG_RTL8723BS is =
not set=0A# CONFIG_R8712U is not set=0A# CONFIG_R8188EU is not set=0A# CO=
NFIG_RTS5208 is not set=0A# CONFIG_VT6655 is not set=0A# CONFIG_VT6656 is=
 not set=0A# CONFIG_FB_SM750 is not set=0ACONFIG_STAGING_MEDIA=3Dy=0A# CO=
NFIG_INTEL_ATOMISP is not set=0A# CONFIG_VIDEO_ZORAN is not set=0A# CONFI=
G_VIDEO_IPU3_IMGU is not set=0A# CONFIG_DVB_AV7110 is not set=0A# CONFIG_=
LTE_GDM724X is not set=0A# CONFIG_FB_TFT is not set=0A# CONFIG_KS7010 is =
not set=0A# CONFIG_PI433 is not set=0A# CONFIG_FIELDBUS_DEV is not set=0A=
# CONFIG_QLGE is not set=0A=0A#=0A# VME Device Drivers=0A#=0ACONFIG_X86_P=
LATFORM_DEVICES=3Dy=0ACONFIG_ACPI_WMI=3Dm=0ACONFIG_WMI_BMOF=3Dm=0A# CONFI=
G_MXM_WMI is not set=0A# CONFIG_PEAQ_WMI is not set=0A# CONFIG_NVIDIA_WMI=
_EC_BACKLIGHT is not set=0A# CONFIG_XIAOMI_WMI is not set=0A# CONFIG_GIGA=
BYTE_WMI is not set=0A# CONFIG_YOGABOOK_WMI is not set=0A# CONFIG_ACERHDF=
 is not set=0A# CONFIG_ACER_WIRELESS is not set=0A# CONFIG_ACER_WMI is no=
t set=0A# CONFIG_AMD_PMC is not set=0A# CONFIG_AMD_HSMP is not set=0A# CO=
NFIG_ADV_SWBUTTON is not set=0A# CONFIG_APPLE_GMUX is not set=0A# CONFIG_=
ASUS_LAPTOP is not set=0A# CONFIG_ASUS_WIRELESS is not set=0A# CONFIG_ASU=
S_TF103C_DOCK is not set=0A# CONFIG_EEEPC_LAPTOP is not set=0A# CONFIG_X8=
6_PLATFORM_DRIVERS_DELL is not set=0A# CONFIG_AMILO_RFKILL is not set=0A#=
 CONFIG_FUJITSU_LAPTOP is not set=0A# CONFIG_FUJITSU_TABLET is not set=0A=
# CONFIG_GPD_POCKET_FAN is not set=0A# CONFIG_HP_ACCEL is not set=0A# CON=
FIG_WIRELESS_HOTKEY is not set=0A# CONFIG_HP_WMI is not set=0A# CONFIG_IB=
M_RTL is not set=0A# CONFIG_IDEAPAD_LAPTOP is not set=0A# CONFIG_SENSORS_=
HDAPS is not set=0A# CONFIG_THINKPAD_LMI is not set=0A# CONFIG_INTEL_ATOM=
ISP2_PM is not set=0A# CONFIG_INTEL_SAR_INT1092 is not set=0A# CONFIG_INT=
EL_SKL_INT3472 is not set=0ACONFIG_INTEL_PMC_CORE=3Dm=0A=0A#=0A# Intel Sp=
eed Select Technology interface support=0A#=0A# CONFIG_INTEL_SPEED_SELECT=
_INTERFACE is not set=0A# end of Intel Speed Select Technology interface =
support=0A=0ACONFIG_INTEL_WMI=3Dy=0A# CONFIG_INTEL_WMI_SBL_FW_UPDATE is n=
ot set=0ACONFIG_INTEL_WMI_THUNDERBOLT=3Dm=0A=0A#=0A# Intel Uncore Frequen=
cy Control=0A#=0A# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set=0A# end of=
 Intel Uncore Frequency Control=0A=0A# CONFIG_INTEL_HID_EVENT is not set=0A=
# CONFIG_INTEL_VBTN is not set=0A# CONFIG_INTEL_INT0002_VGPIO is not set=0A=
# CONFIG_INTEL_OAKTRAIL is not set=0A# CONFIG_INTEL_PUNIT_IPC is not set=0A=
# CONFIG_INTEL_RST is not set=0A# CONFIG_INTEL_SMARTCONNECT is not set=0A=
CONFIG_INTEL_TURBO_MAX_3=3Dy=0A# CONFIG_INTEL_VSEC is not set=0A# CONFIG_=
MSI_LAPTOP is not set=0A# CONFIG_MSI_WMI is not set=0A# CONFIG_PCENGINES_=
APU2 is not set=0A# CONFIG_BARCO_P50_GPIO is not set=0A# CONFIG_SAMSUNG_L=
APTOP is not set=0A# CONFIG_SAMSUNG_Q10 is not set=0A# CONFIG_TOSHIBA_BT_=
RFKILL is not set=0A# CONFIG_TOSHIBA_HAPS is not set=0A# CONFIG_TOSHIBA_W=
MI is not set=0A# CONFIG_ACPI_CMPC is not set=0A# CONFIG_COMPAL_LAPTOP is=
 not set=0A# CONFIG_PANASONIC_LAPTOP is not set=0A# CONFIG_SONY_LAPTOP is=
 not set=0A# CONFIG_TOPSTAR_LAPTOP is not set=0A# CONFIG_SERIAL_MULTI_INS=
TANTIATE is not set=0A# CONFIG_MLX_PLATFORM is not set=0A# CONFIG_X86_AND=
ROID_TABLETS is not set=0A# CONFIG_INTEL_IPS is not set=0A# CONFIG_INTEL_=
SCU_PCI is not set=0A# CONFIG_INTEL_SCU_PLATFORM is not set=0A# CONFIG_SI=
EMENS_SIMATIC_IPC is not set=0A# CONFIG_WINMATE_FM07_KEYS is not set=0ACO=
NFIG_PMC_ATOM=3Dy=0ACONFIG_CHROME_PLATFORMS=3Dy=0A# CONFIG_CHROMEOS_ACPI =
is not set=0A# CONFIG_CHROMEOS_LAPTOP is not set=0A# CONFIG_CHROMEOS_PSTO=
RE is not set=0A# CONFIG_CHROMEOS_TBMC is not set=0A# CONFIG_CROS_EC is n=
ot set=0A# CONFIG_CROS_KBD_LED_BACKLIGHT is not set=0A# CONFIG_CHROMEOS_P=
RIVACY_SCREEN is not set=0A# CONFIG_MELLANOX_PLATFORM is not set=0ACONFIG=
_SURFACE_PLATFORMS=3Dy=0A# CONFIG_SURFACE3_WMI is not set=0A# CONFIG_SURF=
ACE_3_POWER_OPREGION is not set=0A# CONFIG_SURFACE_GPE is not set=0A# CON=
FIG_SURFACE_HOTPLUG is not set=0A# CONFIG_SURFACE_PRO3_BUTTON is not set=0A=
# CONFIG_SURFACE_AGGREGATOR is not set=0ACONFIG_HAVE_CLK=3Dy=0ACONFIG_HAV=
E_CLK_PREPARE=3Dy=0ACONFIG_COMMON_CLK=3Dy=0A# CONFIG_LMK04832 is not set=0A=
# CONFIG_COMMON_CLK_MAX9485 is not set=0A# CONFIG_COMMON_CLK_SI5341 is no=
t set=0A# CONFIG_COMMON_CLK_SI5351 is not set=0A# CONFIG_COMMON_CLK_SI544=
 is not set=0A# CONFIG_COMMON_CLK_CDCE706 is not set=0A# CONFIG_COMMON_CL=
K_CS2000_CP is not set=0A# CONFIG_COMMON_CLK_PWM is not set=0A# CONFIG_XI=
LINX_VCU is not set=0A# CONFIG_HWSPINLOCK is not set=0A=0A#=0A# Clock Sou=
rce drivers=0A#=0ACONFIG_CLKEVT_I8253=3Dy=0ACONFIG_I8253_LOCK=3Dy=0ACONFI=
G_CLKBLD_I8253=3Dy=0A# end of Clock Source drivers=0A=0ACONFIG_MAILBOX=3D=
y=0ACONFIG_PCC=3Dy=0A# CONFIG_ALTERA_MBOX is not set=0ACONFIG_IOMMU_IOVA=3D=
y=0ACONFIG_IOASID=3Dy=0ACONFIG_IOMMU_API=3Dy=0ACONFIG_IOMMU_SUPPORT=3Dy=0A=
=0A#=0A# Generic IOMMU Pagetable Support=0A#=0ACONFIG_IOMMU_IO_PGTABLE=3D=
y=0A# end of Generic IOMMU Pagetable Support=0A=0A# CONFIG_IOMMU_DEBUGFS =
is not set=0A# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set=0ACONFIG_IOMMU_=
DEFAULT_DMA_LAZY=3Dy=0A# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set=0ACO=
NFIG_IOMMU_DMA=3Dy=0ACONFIG_IOMMU_SVA=3Dy=0ACONFIG_AMD_IOMMU=3Dy=0ACONFIG=
_AMD_IOMMU_V2=3Dy=0ACONFIG_DMAR_TABLE=3Dy=0ACONFIG_INTEL_IOMMU=3Dy=0ACONF=
IG_INTEL_IOMMU_SVM=3Dy=0A# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set=0ACON=
FIG_INTEL_IOMMU_FLOPPY_WA=3Dy=0ACONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_=
ON=3Dy=0ACONFIG_IRQ_REMAP=3Dy=0A=0A#=0A# Remoteproc drivers=0A#=0A# CONFI=
G_REMOTEPROC is not set=0A# end of Remoteproc drivers=0A=0A#=0A# Rpmsg dr=
ivers=0A#=0A# CONFIG_RPMSG_QCOM_GLINK_RPM is not set=0A# CONFIG_RPMSG_VIR=
TIO is not set=0A# end of Rpmsg drivers=0A=0A# CONFIG_SOUNDWIRE is not se=
t=0A=0A#=0A# SOC (System On Chip) specific Drivers=0A#=0A=0A#=0A# Amlogic=
 SoC drivers=0A#=0A# end of Amlogic SoC drivers=0A=0A#=0A# Broadcom SoC d=
rivers=0A#=0A# end of Broadcom SoC drivers=0A=0A#=0A# NXP/Freescale QorIQ=
 SoC drivers=0A#=0A# end of NXP/Freescale QorIQ SoC drivers=0A=0A#=0A# i.=
MX SoC drivers=0A#=0A# end of i.MX SoC drivers=0A=0A#=0A# Enable LiteX So=
C Builder specific drivers=0A#=0A# end of Enable LiteX SoC Builder specif=
ic drivers=0A=0A#=0A# Qualcomm SoC drivers=0A#=0A# end of Qualcomm SoC dr=
ivers=0A=0A# CONFIG_SOC_TI is not set=0A=0A#=0A# Xilinx SoC drivers=0A#=0A=
# end of Xilinx SoC drivers=0A# end of SOC (System On Chip) specific Driv=
ers=0A=0ACONFIG_PM_DEVFREQ=3Dy=0A=0A#=0A# DEVFREQ Governors=0A#=0A# CONFI=
G_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set=0A# CONFIG_DEVFREQ_GOV_PERFORMAN=
CE is not set=0A# CONFIG_DEVFREQ_GOV_POWERSAVE is not set=0A# CONFIG_DEVF=
REQ_GOV_USERSPACE is not set=0A# CONFIG_DEVFREQ_GOV_PASSIVE is not set=0A=
=0A#=0A# DEVFREQ Drivers=0A#=0A# CONFIG_PM_DEVFREQ_EVENT is not set=0A# C=
ONFIG_EXTCON is not set=0ACONFIG_MEMORY=3Dy=0A# CONFIG_IIO is not set=0A#=
 CONFIG_NTB is not set=0A# CONFIG_VME_BUS is not set=0ACONFIG_PWM=3Dy=0AC=
ONFIG_PWM_SYSFS=3Dy=0A# CONFIG_PWM_DEBUG is not set=0ACONFIG_PWM_CRC=3Dy=0A=
# CONFIG_PWM_DWC is not set=0A# CONFIG_PWM_LPSS_PCI is not set=0A# CONFIG=
_PWM_LPSS_PLATFORM is not set=0A# CONFIG_PWM_PCA9685 is not set=0A=0A#=0A=
# IRQ chip support=0A#=0A# end of IRQ chip support=0A=0A# CONFIG_IPACK_BU=
S is not set=0ACONFIG_RESET_CONTROLLER=3Dy=0A# CONFIG_RESET_TI_SYSCON is =
not set=0A=0A#=0A# PHY Subsystem=0A#=0ACONFIG_GENERIC_PHY=3Dy=0A# CONFIG_=
USB_LGM_PHY is not set=0A# CONFIG_PHY_CAN_TRANSCEIVER is not set=0A=0A#=0A=
# PHY drivers for Broadcom platforms=0A#=0A# CONFIG_BCM_KONA_USB2_PHY is =
not set=0A# end of PHY drivers for Broadcom platforms=0A=0A# CONFIG_PHY_P=
XA_28NM_HSIC is not set=0A# CONFIG_PHY_PXA_28NM_USB2 is not set=0A# CONFI=
G_PHY_INTEL_LGM_EMMC is not set=0A# end of PHY Subsystem=0A=0ACONFIG_POWE=
RCAP=3Dy=0A# CONFIG_INTEL_RAPL is not set=0A# CONFIG_IDLE_INJECT is not s=
et=0A# CONFIG_MCB is not set=0A=0A#=0A# Performance monitor support=0A#=0A=
# end of Performance monitor support=0A=0ACONFIG_RAS=3Dy=0A# CONFIG_RAS_C=
EC is not set=0A# CONFIG_USB4 is not set=0A=0A#=0A# Android=0A#=0ACONFIG_=
ANDROID=3Dy=0A# CONFIG_ANDROID_BINDER_IPC is not set=0A# end of Android=0A=
=0A# CONFIG_LIBNVDIMM is not set=0ACONFIG_DAX=3Dy=0A# CONFIG_DEV_DAX_HMEM=
 is not set=0ACONFIG_NVMEM=3Dy=0ACONFIG_NVMEM_SYSFS=3Dy=0A# CONFIG_NVMEM_=
RMEM is not set=0A=0A#=0A# HW tracing support=0A#=0A# CONFIG_STM is not s=
et=0A# CONFIG_INTEL_TH is not set=0A# end of HW tracing support=0A=0A# CO=
NFIG_FPGA is not set=0A# CONFIG_TEE is not set=0ACONFIG_PM_OPP=3Dy=0A# CO=
NFIG_SIOX is not set=0A# CONFIG_SLIMBUS is not set=0A# CONFIG_INTERCONNEC=
T is not set=0A# CONFIG_COUNTER is not set=0A# CONFIG_MOST is not set=0A#=
 CONFIG_PECI is not set=0A# CONFIG_HTE is not set=0A# end of Device Drive=
rs=0A=0A#=0A# File systems=0A#=0ACONFIG_DCACHE_WORD_ACCESS=3Dy=0A# CONFIG=
_VALIDATE_FS_PARSER is not set=0ACONFIG_FS_IOMAP=3Dy=0A# CONFIG_EXT2_FS i=
s not set=0A# CONFIG_EXT3_FS is not set=0ACONFIG_EXT4_FS=3Dm=0ACONFIG_EXT=
4_USE_FOR_EXT2=3Dy=0ACONFIG_EXT4_FS_POSIX_ACL=3Dy=0ACONFIG_EXT4_FS_SECURI=
TY=3Dy=0A# CONFIG_EXT4_DEBUG is not set=0ACONFIG_JBD2=3Dm=0A# CONFIG_JBD2=
_DEBUG is not set=0ACONFIG_FS_MBCACHE=3Dm=0A# CONFIG_REISERFS_FS is not s=
et=0A# CONFIG_JFS_FS is not set=0A# CONFIG_XFS_FS is not set=0A# CONFIG_G=
FS2_FS is not set=0A# CONFIG_OCFS2_FS is not set=0A# CONFIG_BTRFS_FS is n=
ot set=0A# CONFIG_NILFS2_FS is not set=0A# CONFIG_F2FS_FS is not set=0A# =
CONFIG_ZONEFS_FS is not set=0ACONFIG_FS_DAX=3Dy=0ACONFIG_FS_POSIX_ACL=3Dy=
=0ACONFIG_EXPORTFS=3Dy=0ACONFIG_EXPORTFS_BLOCK_OPS=3Dy=0ACONFIG_FILE_LOCK=
ING=3Dy=0ACONFIG_FS_ENCRYPTION=3Dy=0ACONFIG_FS_ENCRYPTION_ALGS=3Dm=0ACONF=
IG_FS_VERITY=3Dy=0A# CONFIG_FS_VERITY_DEBUG is not set=0ACONFIG_FS_VERITY=
_BUILTIN_SIGNATURES=3Dy=0ACONFIG_FSNOTIFY=3Dy=0ACONFIG_DNOTIFY=3Dy=0ACONF=
IG_INOTIFY_USER=3Dy=0ACONFIG_FANOTIFY=3Dy=0ACONFIG_FANOTIFY_ACCESS_PERMIS=
SIONS=3Dy=0ACONFIG_QUOTA=3Dy=0ACONFIG_QUOTA_NETLINK_INTERFACE=3Dy=0ACONFI=
G_PRINT_QUOTA_WARNING=3Dy=0A# CONFIG_QUOTA_DEBUG is not set=0A# CONFIG_QF=
MT_V1 is not set=0A# CONFIG_QFMT_V2 is not set=0ACONFIG_QUOTACTL=3Dy=0A# =
CONFIG_AUTOFS4_FS is not set=0ACONFIG_AUTOFS_FS=3Dm=0ACONFIG_FUSE_FS=3Dm=0A=
# CONFIG_CUSE is not set=0A# CONFIG_VIRTIO_FS is not set=0A# CONFIG_OVERL=
AY_FS is not set=0A=0A#=0A# Caches=0A#=0A# CONFIG_FSCACHE is not set=0A# =
end of Caches=0A=0A#=0A# CD-ROM/DVD Filesystems=0A#=0A# CONFIG_ISO9660_FS=
 is not set=0A# CONFIG_UDF_FS is not set=0A# end of CD-ROM/DVD Filesystem=
s=0A=0A#=0A# DOS/FAT/EXFAT/NT Filesystems=0A#=0ACONFIG_FAT_FS=3Dm=0A# CON=
FIG_MSDOS_FS is not set=0ACONFIG_VFAT_FS=3Dm=0ACONFIG_FAT_DEFAULT_CODEPAG=
E=3D437=0ACONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"=0A# CONFIG_FAT_DEFAU=
LT_UTF8 is not set=0A# CONFIG_EXFAT_FS is not set=0A# CONFIG_NTFS_FS is n=
ot set=0A# CONFIG_NTFS3_FS is not set=0A# end of DOS/FAT/EXFAT/NT Filesys=
tems=0A=0A#=0A# Pseudo filesystems=0A#=0ACONFIG_PROC_FS=3Dy=0ACONFIG_PROC=
_KCORE=3Dy=0ACONFIG_PROC_VMCORE=3Dy=0A# CONFIG_PROC_VMCORE_DEVICE_DUMP is=
 not set=0ACONFIG_PROC_SYSCTL=3Dy=0ACONFIG_PROC_PAGE_MONITOR=3Dy=0ACONFIG=
_PROC_CHILDREN=3Dy=0ACONFIG_PROC_PID_ARCH_STATUS=3Dy=0ACONFIG_PROC_CPU_RE=
SCTRL=3Dy=0ACONFIG_KERNFS=3Dy=0ACONFIG_SYSFS=3Dy=0ACONFIG_TMPFS=3Dy=0ACON=
FIG_TMPFS_POSIX_ACL=3Dy=0ACONFIG_TMPFS_XATTR=3Dy=0A# CONFIG_TMPFS_INODE64=
 is not set=0ACONFIG_HUGETLBFS=3Dy=0ACONFIG_HUGETLB_PAGE=3Dy=0ACONFIG_ARC=
H_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=3Dy=0ACONFIG_HUGETLB_PAGE_OPTIMIZE_V=
MEMMAP=3Dy=0A# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set=
=0ACONFIG_MEMFD_CREATE=3Dy=0ACONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy=0ACONFIG_C=
ONFIGFS_FS=3Dm=0ACONFIG_EFIVAR_FS=3Dm=0A# end of Pseudo filesystems=0A=0A=
CONFIG_MISC_FILESYSTEMS=3Dy=0A# CONFIG_ORANGEFS_FS is not set=0A# CONFIG_=
ADFS_FS is not set=0A# CONFIG_AFFS_FS is not set=0A# CONFIG_ECRYPT_FS is =
not set=0A# CONFIG_HFS_FS is not set=0A# CONFIG_HFSPLUS_FS is not set=0A#=
 CONFIG_BEFS_FS is not set=0A# CONFIG_BFS_FS is not set=0A# CONFIG_EFS_FS=
 is not set=0A# CONFIG_CRAMFS is not set=0A# CONFIG_SQUASHFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A# CONFIG_MINIX_FS is not set=0A# CONFIG_OMF=
S_FS is not set=0A# CONFIG_HPFS_FS is not set=0A# CONFIG_QNX4FS_FS is not=
 set=0A# CONFIG_QNX6FS_FS is not set=0A# CONFIG_ROMFS_FS is not set=0ACON=
FIG_PSTORE=3Dy=0ACONFIG_PSTORE_DEFAULT_KMSG_BYTES=3D10240=0ACONFIG_PSTORE=
_DEFLATE_COMPRESS=3Dy=0A# CONFIG_PSTORE_LZO_COMPRESS is not set=0A# CONFI=
G_PSTORE_LZ4_COMPRESS is not set=0A# CONFIG_PSTORE_LZ4HC_COMPRESS is not =
set=0A# CONFIG_PSTORE_842_COMPRESS is not set=0A# CONFIG_PSTORE_ZSTD_COMP=
RESS is not set=0ACONFIG_PSTORE_COMPRESS=3Dy=0ACONFIG_PSTORE_DEFLATE_COMP=
RESS_DEFAULT=3Dy=0ACONFIG_PSTORE_COMPRESS_DEFAULT=3D"deflate"=0A# CONFIG_=
PSTORE_CONSOLE is not set=0A# CONFIG_PSTORE_PMSG is not set=0A# CONFIG_PS=
TORE_FTRACE is not set=0A# CONFIG_PSTORE_RAM is not set=0A# CONFIG_PSTORE=
_BLK is not set=0A# CONFIG_SYSV_FS is not set=0A# CONFIG_UFS_FS is not se=
t=0A# CONFIG_EROFS_FS is not set=0ACONFIG_NETWORK_FILESYSTEMS=3Dy=0A# CON=
FIG_NFS_FS is not set=0A# CONFIG_NFSD is not set=0A# CONFIG_CEPH_FS is no=
t set=0ACONFIG_CIFS=3Dy=0A# CONFIG_CIFS_STATS2 is not set=0ACONFIG_CIFS_A=
LLOW_INSECURE_LEGACY=3Dy=0A# CONFIG_CIFS_UPCALL is not set=0ACONFIG_CIFS_=
XATTR=3Dy=0ACONFIG_CIFS_POSIX=3Dy=0ACONFIG_CIFS_DEBUG=3Dy=0A# CONFIG_CIFS=
_DEBUG2 is not set=0A# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set=0A# CONFIG_=
CIFS_DFS_UPCALL is not set=0A# CONFIG_CIFS_SWN_UPCALL is not set=0A# CONF=
IG_SMB_SERVER is not set=0ACONFIG_SMBFS_COMMON=3Dy=0A# CONFIG_CODA_FS is =
not set=0A# CONFIG_AFS_FS is not set=0ACONFIG_NLS=3Dy=0ACONFIG_NLS_DEFAUL=
T=3D"utf8"=0ACONFIG_NLS_CODEPAGE_437=3Dm=0A# CONFIG_NLS_CODEPAGE_737 is n=
ot set=0A# CONFIG_NLS_CODEPAGE_775 is not set=0A# CONFIG_NLS_CODEPAGE_850=
 is not set=0A# CONFIG_NLS_CODEPAGE_852 is not set=0A# CONFIG_NLS_CODEPAG=
E_855 is not set=0A# CONFIG_NLS_CODEPAGE_857 is not set=0A# CONFIG_NLS_CO=
DEPAGE_860 is not set=0A# CONFIG_NLS_CODEPAGE_861 is not set=0A# CONFIG_N=
LS_CODEPAGE_862 is not set=0A# CONFIG_NLS_CODEPAGE_863 is not set=0A# CON=
FIG_NLS_CODEPAGE_864 is not set=0A# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A# CONFIG_NLS_CODEPAGE_869 is not s=
et=0A# CONFIG_NLS_CODEPAGE_936 is not set=0A# CONFIG_NLS_CODEPAGE_950 is =
not set=0A# CONFIG_NLS_CODEPAGE_932 is not set=0A# CONFIG_NLS_CODEPAGE_94=
9 is not set=0A# CONFIG_NLS_CODEPAGE_874 is not set=0A# CONFIG_NLS_ISO885=
9_8 is not set=0A# CONFIG_NLS_CODEPAGE_1250 is not set=0A# CONFIG_NLS_COD=
EPAGE_1251 is not set=0ACONFIG_NLS_ASCII=3Dm=0ACONFIG_NLS_ISO8859_1=3Dy=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A# CONFIG_NLS_ISO8859_3 is not set=0A#=
 CONFIG_NLS_ISO8859_4 is not set=0A# CONFIG_NLS_ISO8859_5 is not set=0A# =
CONFIG_NLS_ISO8859_6 is not set=0A# CONFIG_NLS_ISO8859_7 is not set=0A# C=
ONFIG_NLS_ISO8859_9 is not set=0A# CONFIG_NLS_ISO8859_13 is not set=0A# C=
ONFIG_NLS_ISO8859_14 is not set=0A# CONFIG_NLS_ISO8859_15 is not set=0A# =
CONFIG_NLS_KOI8_R is not set=0A# CONFIG_NLS_KOI8_U is not set=0A# CONFIG_=
NLS_MAC_ROMAN is not set=0A# CONFIG_NLS_MAC_CELTIC is not set=0A# CONFIG_=
NLS_MAC_CENTEURO is not set=0A# CONFIG_NLS_MAC_CROATIAN is not set=0A# CO=
NFIG_NLS_MAC_CYRILLIC is not set=0A# CONFIG_NLS_MAC_GAELIC is not set=0A#=
 CONFIG_NLS_MAC_GREEK is not set=0A# CONFIG_NLS_MAC_ICELAND is not set=0A=
# CONFIG_NLS_MAC_INUIT is not set=0A# CONFIG_NLS_MAC_ROMANIAN is not set=0A=
# CONFIG_NLS_MAC_TURKISH is not set=0A# CONFIG_NLS_UTF8 is not set=0A# CO=
NFIG_DLM is not set=0A# CONFIG_UNICODE is not set=0ACONFIG_IO_WQ=3Dy=0A# =
end of File systems=0A=0A#=0A# Security options=0A#=0ACONFIG_KEYS=3Dy=0A#=
 CONFIG_KEYS_REQUEST_CACHE is not set=0ACONFIG_PERSISTENT_KEYRINGS=3Dy=0A=
# CONFIG_TRUSTED_KEYS is not set=0A# CONFIG_ENCRYPTED_KEYS is not set=0AC=
ONFIG_KEY_DH_OPERATIONS=3Dy=0ACONFIG_SECURITY_DMESG_RESTRICT=3Dy=0ACONFIG=
_SECURITY=3Dy=0ACONFIG_SECURITYFS=3Dy=0ACONFIG_SECURITY_NETWORK=3Dy=0ACON=
FIG_SECURITY_NETWORK_XFRM=3Dy=0ACONFIG_SECURITY_PATH=3Dy=0ACONFIG_INTEL_T=
XT=3Dy=0ACONFIG_LSM_MMAP_MIN_ADDR=3D65536=0ACONFIG_HAVE_HARDENED_USERCOPY=
_ALLOCATOR=3Dy=0ACONFIG_HARDENED_USERCOPY=3Dy=0ACONFIG_FORTIFY_SOURCE=3Dy=
=0A# CONFIG_STATIC_USERMODEHELPER is not set=0ACONFIG_SECURITY_SELINUX=3D=
y=0A# CONFIG_SECURITY_SELINUX_BOOTPARAM is not set=0A# CONFIG_SECURITY_SE=
LINUX_DISABLE is not set=0ACONFIG_SECURITY_SELINUX_DEVELOP=3Dy=0ACONFIG_S=
ECURITY_SELINUX_AVC_STATS=3Dy=0ACONFIG_SECURITY_SELINUX_CHECKREQPROT_VALU=
E=3D0=0ACONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=3D9=0ACONFIG_SECURITY_SE=
LINUX_SID2STR_CACHE_SIZE=3D256=0A# CONFIG_SECURITY_SMACK is not set=0ACON=
FIG_SECURITY_TOMOYO=3Dy=0ACONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=3D2048=0A=
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=3D1024=0A# CONFIG_SECURITY_TOMOYO_OM=
IT_USERSPACE_LOADER is not set=0ACONFIG_SECURITY_TOMOYO_POLICY_LOADER=3D"=
/sbin/tomoyo-init"=0ACONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER=3D"/sbin/i=
nit"=0A# CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set=0ACON=
FIG_SECURITY_APPARMOR=3Dy=0ACONFIG_SECURITY_APPARMOR_HASH=3Dy=0ACONFIG_SE=
CURITY_APPARMOR_HASH_DEFAULT=3Dy=0A# CONFIG_SECURITY_APPARMOR_DEBUG is no=
t set=0A# CONFIG_SECURITY_LOADPIN is not set=0ACONFIG_SECURITY_YAMA=3Dy=0A=
# CONFIG_SECURITY_SAFESETID is not set=0ACONFIG_SECURITY_LOCKDOWN_LSM=3Dy=
=0ACONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3Dy=0ACONFIG_LOCK_DOWN_KERNEL_FORCE=
_NONE=3Dy=0A# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set=0A# CONF=
IG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set=0A# CONFIG_SECURITY_=
LANDLOCK is not set=0ACONFIG_INTEGRITY=3Dy=0ACONFIG_INTEGRITY_SIGNATURE=3D=
y=0ACONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy=0A# CONFIG_INTEGRITY_TRUSTED_KEY=
RING is not set=0ACONFIG_INTEGRITY_PLATFORM_KEYRING=3Dy=0A# CONFIG_INTEGR=
ITY_MACHINE_KEYRING is not set=0ACONFIG_LOAD_UEFI_KEYS=3Dy=0ACONFIG_INTEG=
RITY_AUDIT=3Dy=0A# CONFIG_IMA is not set=0A# CONFIG_IMA_KEYRINGS_PERMIT_S=
IGNED_BY_BUILTIN_OR_SECONDARY is not set=0A# CONFIG_IMA_SECURE_AND_OR_TRU=
STED_BOOT is not set=0A# CONFIG_EVM is not set=0A# CONFIG_DEFAULT_SECURIT=
Y_SELINUX is not set=0A# CONFIG_DEFAULT_SECURITY_TOMOYO is not set=0ACONF=
IG_DEFAULT_SECURITY_APPARMOR=3Dy=0A# CONFIG_DEFAULT_SECURITY_DAC is not s=
et=0ACONFIG_LSM=3D"lockdown,yama,loadpin,safesetid,integrity,apparmor,sel=
inux,smack,tomoyo"=0A=0A#=0A# Kernel hardening options=0A#=0A=0A#=0A# Mem=
ory initialization=0A#=0ACONFIG_INIT_STACK_NONE=3Dy=0ACONFIG_INIT_ON_ALLO=
C_DEFAULT_ON=3Dy=0A# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set=0A# end of=
 Memory initialization=0A=0ACONFIG_RANDSTRUCT_NONE=3Dy=0A# end of Kernel =
hardening options=0A# end of Security options=0A=0ACONFIG_CRYPTO=3Dy=0A=0A=
#=0A# Crypto core or helper=0A#=0ACONFIG_CRYPTO_FIPS=3Dy=0ACONFIG_CRYPTO_=
ALGAPI=3Dy=0ACONFIG_CRYPTO_ALGAPI2=3Dy=0ACONFIG_CRYPTO_AEAD=3Dy=0ACONFIG_=
CRYPTO_AEAD2=3Dy=0ACONFIG_CRYPTO_SKCIPHER=3Dy=0ACONFIG_CRYPTO_SKCIPHER2=3D=
y=0ACONFIG_CRYPTO_HASH=3Dy=0ACONFIG_CRYPTO_HASH2=3Dy=0ACONFIG_CRYPTO_RNG=3D=
y=0ACONFIG_CRYPTO_RNG2=3Dy=0ACONFIG_CRYPTO_RNG_DEFAULT=3Dy=0ACONFIG_CRYPT=
O_AKCIPHER2=3Dy=0ACONFIG_CRYPTO_AKCIPHER=3Dy=0ACONFIG_CRYPTO_KPP2=3Dy=0AC=
ONFIG_CRYPTO_KPP=3Dy=0ACONFIG_CRYPTO_ACOMP2=3Dy=0ACONFIG_CRYPTO_MANAGER=3D=
y=0ACONFIG_CRYPTO_MANAGER2=3Dy=0A# CONFIG_CRYPTO_USER is not set=0A# CONF=
IG_CRYPTO_MANAGER_DISABLE_TESTS is not set=0A# CONFIG_CRYPTO_MANAGER_EXTR=
A_TESTS is not set=0ACONFIG_CRYPTO_GF128MUL=3Dy=0ACONFIG_CRYPTO_NULL=3Dy=0A=
CONFIG_CRYPTO_NULL2=3Dy=0A# CONFIG_CRYPTO_PCRYPT is not set=0ACONFIG_CRYP=
TO_CRYPTD=3Dm=0A# CONFIG_CRYPTO_AUTHENC is not set=0A# CONFIG_CRYPTO_TEST=
 is not set=0ACONFIG_CRYPTO_SIMD=3Dm=0A=0A#=0A# Public-key cryptography=0A=
#=0ACONFIG_CRYPTO_RSA=3Dy=0ACONFIG_CRYPTO_DH=3Dy=0A# CONFIG_CRYPTO_DH_RFC=
7919_GROUPS is not set=0ACONFIG_CRYPTO_ECC=3Dm=0ACONFIG_CRYPTO_ECDH=3Dm=0A=
# CONFIG_CRYPTO_ECDSA is not set=0A# CONFIG_CRYPTO_ECRDSA is not set=0A# =
CONFIG_CRYPTO_SM2 is not set=0A# CONFIG_CRYPTO_CURVE25519 is not set=0A# =
CONFIG_CRYPTO_CURVE25519_X86 is not set=0A=0A#=0A# Authenticated Encrypti=
on with Associated Data=0A#=0ACONFIG_CRYPTO_CCM=3Dy=0ACONFIG_CRYPTO_GCM=3D=
y=0A# CONFIG_CRYPTO_CHACHA20POLY1305 is not set=0A# CONFIG_CRYPTO_AEGIS12=
8 is not set=0A# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set=0ACONFIG_CR=
YPTO_SEQIV=3Dy=0A# CONFIG_CRYPTO_ECHAINIV is not set=0A=0A#=0A# Block mod=
es=0A#=0ACONFIG_CRYPTO_CBC=3Dy=0A# CONFIG_CRYPTO_CFB is not set=0ACONFIG_=
CRYPTO_CTR=3Dy=0ACONFIG_CRYPTO_CTS=3Dy=0ACONFIG_CRYPTO_ECB=3Dy=0A# CONFIG=
_CRYPTO_LRW is not set=0A# CONFIG_CRYPTO_OFB is not set=0A# CONFIG_CRYPTO=
_PCBC is not set=0ACONFIG_CRYPTO_XTS=3Dy=0A# CONFIG_CRYPTO_KEYWRAP is not=
 set=0A# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set=0A# CONFIG_CRYPTO_NHPOL=
Y1305_AVX2 is not set=0A# CONFIG_CRYPTO_ADIANTUM is not set=0A# CONFIG_CR=
YPTO_ESSIV is not set=0A=0A#=0A# Hash modes=0A#=0ACONFIG_CRYPTO_CMAC=3Dy=0A=
CONFIG_CRYPTO_HMAC=3Dy=0A# CONFIG_CRYPTO_XCBC is not set=0A# CONFIG_CRYPT=
O_VMAC is not set=0A=0A#=0A# Digest=0A#=0ACONFIG_CRYPTO_CRC32C=3Dm=0ACONF=
IG_CRYPTO_CRC32C_INTEL=3Dm=0A# CONFIG_CRYPTO_CRC32 is not set=0ACONFIG_CR=
YPTO_CRC32_PCLMUL=3Dm=0A# CONFIG_CRYPTO_XXHASH is not set=0A# CONFIG_CRYP=
TO_BLAKE2B is not set=0A# CONFIG_CRYPTO_BLAKE2S is not set=0A# CONFIG_CRY=
PTO_BLAKE2S_X86 is not set=0ACONFIG_CRYPTO_CRCT10DIF=3Dy=0ACONFIG_CRYPTO_=
CRCT10DIF_PCLMUL=3Dm=0ACONFIG_CRYPTO_CRC64_ROCKSOFT=3Dm=0ACONFIG_CRYPTO_G=
HASH=3Dy=0A# CONFIG_CRYPTO_POLY1305 is not set=0A# CONFIG_CRYPTO_POLY1305=
_X86_64 is not set=0ACONFIG_CRYPTO_MD4=3Dy=0ACONFIG_CRYPTO_MD5=3Dy=0A# CO=
NFIG_CRYPTO_MICHAEL_MIC is not set=0A# CONFIG_CRYPTO_RMD160 is not set=0A=
CONFIG_CRYPTO_SHA1=3Dy=0A# CONFIG_CRYPTO_SHA1_SSSE3 is not set=0A# CONFIG=
_CRYPTO_SHA256_SSSE3 is not set=0A# CONFIG_CRYPTO_SHA512_SSSE3 is not set=
=0ACONFIG_CRYPTO_SHA256=3Dy=0ACONFIG_CRYPTO_SHA512=3Dy=0A# CONFIG_CRYPTO_=
SHA3 is not set=0A# CONFIG_CRYPTO_SM3_GENERIC is not set=0A# CONFIG_CRYPT=
O_SM3_AVX_X86_64 is not set=0A# CONFIG_CRYPTO_STREEBOG is not set=0A# CON=
FIG_CRYPTO_WP512 is not set=0ACONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm=0A=0A=
#=0A# Ciphers=0A#=0ACONFIG_CRYPTO_AES=3Dy=0A# CONFIG_CRYPTO_AES_TI is not=
 set=0ACONFIG_CRYPTO_AES_NI_INTEL=3Dm=0A# CONFIG_CRYPTO_BLOWFISH is not s=
et=0A# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set=0A# CONFIG_CRYPTO_CAMELLI=
A is not set=0A# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set=0A# CONFIG_CRYP=
TO_CAMELLIA_AESNI_AVX_X86_64 is not set=0A# CONFIG_CRYPTO_CAMELLIA_AESNI_=
AVX2_X86_64 is not set=0A# CONFIG_CRYPTO_CAST5 is not set=0A# CONFIG_CRYP=
TO_CAST5_AVX_X86_64 is not set=0A# CONFIG_CRYPTO_CAST6 is not set=0A# CON=
FIG_CRYPTO_CAST6_AVX_X86_64 is not set=0A# CONFIG_CRYPTO_DES is not set=0A=
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set=0A# CONFIG_CRYPTO_FCRYPT is no=
t set=0A# CONFIG_CRYPTO_CHACHA20 is not set=0A# CONFIG_CRYPTO_CHACHA20_X8=
6_64 is not set=0A# CONFIG_CRYPTO_SERPENT is not set=0A# CONFIG_CRYPTO_SE=
RPENT_SSE2_X86_64 is not set=0A# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not =
set=0A# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set=0A# CONFIG_CRYPTO_SM=
4_GENERIC is not set=0A# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set=0A=
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set=0A# CONFIG_CRYPTO_TWOFIS=
H is not set=0A# CONFIG_CRYPTO_TWOFISH_X86_64 is not set=0A# CONFIG_CRYPT=
O_TWOFISH_X86_64_3WAY is not set=0A# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is =
not set=0A=0A#=0A# Compression=0A#=0ACONFIG_CRYPTO_DEFLATE=3Dy=0ACONFIG_C=
RYPTO_LZO=3Dy=0A# CONFIG_CRYPTO_842 is not set=0A# CONFIG_CRYPTO_LZ4 is n=
ot set=0A# CONFIG_CRYPTO_LZ4HC is not set=0A# CONFIG_CRYPTO_ZSTD is not s=
et=0A=0A#=0A# Random Number Generation=0A#=0ACONFIG_CRYPTO_ANSI_CPRNG=3Dm=
=0ACONFIG_CRYPTO_DRBG_MENU=3Dy=0ACONFIG_CRYPTO_DRBG_HMAC=3Dy=0ACONFIG_CRY=
PTO_DRBG_HASH=3Dy=0A# CONFIG_CRYPTO_DRBG_CTR is not set=0ACONFIG_CRYPTO_D=
RBG=3Dy=0ACONFIG_CRYPTO_JITTERENTROPY=3Dy=0ACONFIG_CRYPTO_KDF800108_CTR=3D=
y=0A# CONFIG_CRYPTO_USER_API_HASH is not set=0A# CONFIG_CRYPTO_USER_API_S=
KCIPHER is not set=0A# CONFIG_CRYPTO_USER_API_RNG is not set=0A# CONFIG_C=
RYPTO_USER_API_AEAD is not set=0ACONFIG_CRYPTO_HASH_INFO=3Dy=0ACONFIG_CRY=
PTO_HW=3Dy=0A# CONFIG_CRYPTO_DEV_PADLOCK is not set=0A# CONFIG_CRYPTO_DEV=
_ATMEL_ECC is not set=0A# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set=0ACO=
NFIG_CRYPTO_DEV_CCP=3Dy=0A# CONFIG_CRYPTO_DEV_CCP_DD is not set=0A# CONFI=
G_CRYPTO_DEV_QAT_DH895xCC is not set=0A# CONFIG_CRYPTO_DEV_QAT_C3XXX is n=
ot set=0A# CONFIG_CRYPTO_DEV_QAT_C62X is not set=0A# CONFIG_CRYPTO_DEV_QA=
T_4XXX is not set=0A# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set=0A# CON=
FIG_CRYPTO_DEV_QAT_C3XXXVF is not set=0A# CONFIG_CRYPTO_DEV_QAT_C62XVF is=
 not set=0A# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set=0A# CONFIG_CRYPT=
O_DEV_SAFEXCEL is not set=0A# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set=0A=
CONFIG_ASYMMETRIC_KEY_TYPE=3Dy=0ACONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy=
=0ACONFIG_X509_CERTIFICATE_PARSER=3Dy=0A# CONFIG_PKCS8_PRIVATE_KEY_PARSER=
 is not set=0ACONFIG_PKCS7_MESSAGE_PARSER=3Dy=0A# CONFIG_PKCS7_TEST_KEY i=
s not set=0ACONFIG_SIGNED_PE_FILE_VERIFICATION=3Dy=0A# CONFIG_FIPS_SIGNAT=
URE_SELFTEST is not set=0A=0A#=0A# Certificates for signature checking=0A=
#=0ACONFIG_MODULE_SIG_KEY=3D""=0ACONFIG_MODULE_SIG_KEY_TYPE_RSA=3Dy=0A# C=
ONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set=0ACONFIG_SYSTEM_TRUSTED_KEYRIN=
G=3Dy=0ACONFIG_SYSTEM_TRUSTED_KEYS=3D""=0A# CONFIG_SYSTEM_EXTRA_CERTIFICA=
TE is not set=0ACONFIG_SECONDARY_TRUSTED_KEYRING=3Dy=0ACONFIG_SYSTEM_BLAC=
KLIST_KEYRING=3Dy=0ACONFIG_SYSTEM_BLACKLIST_HASH_LIST=3D""=0A# CONFIG_SYS=
TEM_REVOCATION_LIST is not set=0A# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is=
 not set=0A# end of Certificates for signature checking=0A=0ACONFIG_BINAR=
Y_PRINTF=3Dy=0A=0A#=0A# Library routines=0A#=0ACONFIG_LINEAR_RANGES=3Dy=0A=
# CONFIG_PACKING is not set=0ACONFIG_BITREVERSE=3Dy=0ACONFIG_GENERIC_STRN=
CPY_FROM_USER=3Dy=0ACONFIG_GENERIC_STRNLEN_USER=3Dy=0ACONFIG_GENERIC_NET_=
UTILS=3Dy=0A# CONFIG_CORDIC is not set=0ACONFIG_PRIME_NUMBERS=3Dm=0ACONFI=
G_RATIONAL=3Dy=0ACONFIG_GENERIC_PCI_IOMAP=3Dy=0ACONFIG_GENERIC_IOMAP=3Dy=0A=
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy=0ACONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy=
=0ACONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy=0A=0A#=0A# Crypto library routines=
=0A#=0ACONFIG_CRYPTO_LIB_AES=3Dy=0ACONFIG_CRYPTO_LIB_ARC4=3Dm=0ACONFIG_CR=
YPTO_LIB_BLAKE2S_GENERIC=3Dy=0A# CONFIG_CRYPTO_LIB_CHACHA is not set=0A# =
CONFIG_CRYPTO_LIB_CURVE25519 is not set=0ACONFIG_CRYPTO_LIB_POLY1305_RSIZ=
E=3D11=0A# CONFIG_CRYPTO_LIB_POLY1305 is not set=0A# CONFIG_CRYPTO_LIB_CH=
ACHA20POLY1305 is not set=0ACONFIG_CRYPTO_LIB_SHA256=3Dy=0A# end of Crypt=
o library routines=0A=0ACONFIG_LIB_MEMNEQ=3Dy=0ACONFIG_CRC_CCITT=3Dy=0ACO=
NFIG_CRC16=3Dm=0ACONFIG_CRC_T10DIF=3Dy=0ACONFIG_CRC64_ROCKSOFT=3Dm=0A# CO=
NFIG_CRC_ITU_T is not set=0ACONFIG_CRC32=3Dy=0A# CONFIG_CRC32_SELFTEST is=
 not set=0ACONFIG_CRC32_SLICEBY8=3Dy=0A# CONFIG_CRC32_SLICEBY4 is not set=
=0A# CONFIG_CRC32_SARWATE is not set=0A# CONFIG_CRC32_BIT is not set=0ACO=
NFIG_CRC64=3Dm=0A# CONFIG_CRC4 is not set=0A# CONFIG_CRC7 is not set=0A# =
CONFIG_LIBCRC32C is not set=0A# CONFIG_CRC8 is not set=0ACONFIG_XXHASH=3D=
y=0A# CONFIG_RANDOM32_SELFTEST is not set=0ACONFIG_ZLIB_INFLATE=3Dy=0ACON=
FIG_ZLIB_DEFLATE=3Dy=0ACONFIG_LZO_COMPRESS=3Dy=0ACONFIG_LZO_DECOMPRESS=3D=
y=0ACONFIG_LZ4_DECOMPRESS=3Dy=0ACONFIG_ZSTD_DECOMPRESS=3Dy=0ACONFIG_XZ_DE=
C=3Dy=0ACONFIG_XZ_DEC_X86=3Dy=0A# CONFIG_XZ_DEC_POWERPC is not set=0A# CO=
NFIG_XZ_DEC_IA64 is not set=0A# CONFIG_XZ_DEC_ARM is not set=0A# CONFIG_X=
Z_DEC_ARMTHUMB is not set=0A# CONFIG_XZ_DEC_SPARC is not set=0A# CONFIG_X=
Z_DEC_MICROLZMA is not set=0ACONFIG_XZ_DEC_BCJ=3Dy=0A# CONFIG_XZ_DEC_TEST=
 is not set=0ACONFIG_DECOMPRESS_GZIP=3Dy=0ACONFIG_DECOMPRESS_BZIP2=3Dy=0A=
CONFIG_DECOMPRESS_LZMA=3Dy=0ACONFIG_DECOMPRESS_XZ=3Dy=0ACONFIG_DECOMPRESS=
_LZO=3Dy=0ACONFIG_DECOMPRESS_LZ4=3Dy=0ACONFIG_DECOMPRESS_ZSTD=3Dy=0ACONFI=
G_GENERIC_ALLOCATOR=3Dy=0ACONFIG_INTERVAL_TREE=3Dy=0ACONFIG_XARRAY_MULTI=3D=
y=0ACONFIG_ASSOCIATIVE_ARRAY=3Dy=0ACONFIG_HAS_IOMEM=3Dy=0ACONFIG_HAS_IOPO=
RT_MAP=3Dy=0ACONFIG_HAS_DMA=3Dy=0ACONFIG_DMA_OPS=3Dy=0ACONFIG_NEED_SG_DMA=
_LENGTH=3Dy=0ACONFIG_NEED_DMA_MAP_STATE=3Dy=0ACONFIG_ARCH_DMA_ADDR_T_64BI=
T=3Dy=0ACONFIG_SWIOTLB=3Dy=0A# CONFIG_DMA_API_DEBUG is not set=0A# CONFIG=
_DMA_MAP_BENCHMARK is not set=0ACONFIG_SGL_ALLOC=3Dy=0ACONFIG_IOMMU_HELPE=
R=3Dy=0ACONFIG_CHECK_SIGNATURE=3Dy=0ACONFIG_CPU_RMAP=3Dy=0ACONFIG_DQL=3Dy=
=0ACONFIG_GLOB=3Dy=0A# CONFIG_GLOB_SELFTEST is not set=0ACONFIG_NLATTR=3D=
y=0ACONFIG_CLZ_TAB=3Dy=0ACONFIG_IRQ_POLL=3Dy=0ACONFIG_MPILIB=3Dy=0ACONFIG=
_SIGNATURE=3Dy=0ACONFIG_OID_REGISTRY=3Dy=0ACONFIG_UCS2_STRING=3Dy=0ACONFI=
G_HAVE_GENERIC_VDSO=3Dy=0ACONFIG_GENERIC_GETTIMEOFDAY=3Dy=0ACONFIG_GENERI=
C_VDSO_TIME_NS=3Dy=0ACONFIG_FONT_SUPPORT=3Dy=0ACONFIG_FONTS=3Dy=0ACONFIG_=
FONT_8x8=3Dy=0ACONFIG_FONT_8x16=3Dy=0A# CONFIG_FONT_6x11 is not set=0A# C=
ONFIG_FONT_7x14 is not set=0A# CONFIG_FONT_PEARL_8x8 is not set=0A# CONFI=
G_FONT_ACORN_8x8 is not set=0A# CONFIG_FONT_MINI_4x6 is not set=0A# CONFI=
G_FONT_6x10 is not set=0A# CONFIG_FONT_10x18 is not set=0A# CONFIG_FONT_S=
UN8x16 is not set=0A# CONFIG_FONT_SUN12x22 is not set=0ACONFIG_FONT_TER16=
x32=3Dy=0A# CONFIG_FONT_6x8 is not set=0ACONFIG_SG_POOL=3Dy=0ACONFIG_ARCH=
_HAS_PMEM_API=3Dy=0ACONFIG_MEMREGION=3Dy=0ACONFIG_ARCH_HAS_UACCESS_FLUSHC=
ACHE=3Dy=0ACONFIG_ARCH_HAS_COPY_MC=3Dy=0ACONFIG_ARCH_STACKWALK=3Dy=0ACONF=
IG_STACKDEPOT=3Dy=0ACONFIG_STACK_HASH_ORDER=3D20=0ACONFIG_SBITMAP=3Dy=0A#=
 end of Library routines=0A=0A#=0A# Kernel hacking=0A#=0A=0A#=0A# printk =
and dmesg options=0A#=0ACONFIG_PRINTK_TIME=3Dy=0A# CONFIG_PRINTK_CALLER i=
s not set=0A# CONFIG_STACKTRACE_BUILD_ID is not set=0ACONFIG_CONSOLE_LOGL=
EVEL_DEFAULT=3D7=0ACONFIG_CONSOLE_LOGLEVEL_QUIET=3D4=0ACONFIG_MESSAGE_LOG=
LEVEL_DEFAULT=3D4=0ACONFIG_BOOT_PRINTK_DELAY=3Dy=0ACONFIG_DYNAMIC_DEBUG=3D=
y=0ACONFIG_DYNAMIC_DEBUG_CORE=3Dy=0ACONFIG_SYMBOLIC_ERRNAME=3Dy=0ACONFIG_=
DEBUG_BUGVERBOSE=3Dy=0A# end of printk and dmesg options=0A=0ACONFIG_DEBU=
G_KERNEL=3Dy=0ACONFIG_DEBUG_MISC=3Dy=0A=0A#=0A# Compile-time checks and c=
ompiler options=0A#=0ACONFIG_DEBUG_INFO=3Dy=0A# CONFIG_DEBUG_INFO_NONE is=
 not set=0ACONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy=0A# CONFIG_DEBUG=
_INFO_DWARF4 is not set=0A# CONFIG_DEBUG_INFO_DWARF5 is not set=0A# CONFI=
G_DEBUG_INFO_REDUCED is not set=0A# CONFIG_DEBUG_INFO_COMPRESSED is not s=
et=0A# CONFIG_DEBUG_INFO_SPLIT is not set=0ACONFIG_DEBUG_INFO_BTF=3Dy=0AC=
ONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy=0ACONFIG_DEBUG_INFO_BTF_MODULES=3Dy=0A# CO=
NFIG_MODULE_ALLOW_BTF_MISMATCH is not set=0A# CONFIG_GDB_SCRIPTS is not s=
et=0ACONFIG_FRAME_WARN=3D2048=0ACONFIG_STRIP_ASM_SYMS=3Dy=0A# CONFIG_READ=
ABLE_ASM is not set=0A# CONFIG_HEADERS_INSTALL is not set=0A# CONFIG_DEBU=
G_SECTION_MISMATCH is not set=0ACONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy=0A#=
 CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set=0ACONFIG_OBJTOOL=3Dy=0A=
CONFIG_VMLINUX_MAP=3Dy=0A# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set=0A#=
 end of Compile-time checks and compiler options=0A=0A#=0A# Generic Kerne=
l Debugging Instruments=0A#=0ACONFIG_MAGIC_SYSRQ=3Dy=0ACONFIG_MAGIC_SYSRQ=
_DEFAULT_ENABLE=3D0x01b6=0ACONFIG_MAGIC_SYSRQ_SERIAL=3Dy=0ACONFIG_MAGIC_S=
YSRQ_SERIAL_SEQUENCE=3D""=0ACONFIG_DEBUG_FS=3Dy=0ACONFIG_DEBUG_FS_ALLOW_A=
LL=3Dy=0A# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set=0A# CONFIG_DEBUG_FS_=
ALLOW_NONE is not set=0ACONFIG_HAVE_ARCH_KGDB=3Dy=0A# CONFIG_KGDB is not =
set=0ACONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy=0A# CONFIG_UBSAN is not set=0A=
CONFIG_HAVE_ARCH_KCSAN=3Dy=0A# end of Generic Kernel Debugging Instrument=
s=0A=0A#=0A# Networking Debugging=0A#=0A# CONFIG_NET_DEV_REFCNT_TRACKER i=
s not set=0A# CONFIG_NET_NS_REFCNT_TRACKER is not set=0A# CONFIG_DEBUG_NE=
T is not set=0A# end of Networking Debugging=0A=0A#=0A# Memory Debugging=0A=
#=0ACONFIG_PAGE_EXTENSION=3Dy=0A# CONFIG_DEBUG_PAGEALLOC is not set=0ACON=
FIG_SLUB_DEBUG=3Dy=0A# CONFIG_SLUB_DEBUG_ON is not set=0A# CONFIG_PAGE_OW=
NER is not set=0A# CONFIG_PAGE_TABLE_CHECK is not set=0ACONFIG_PAGE_POISO=
NING=3Dy=0A# CONFIG_DEBUG_PAGE_REF is not set=0A# CONFIG_DEBUG_RODATA_TES=
T is not set=0ACONFIG_ARCH_HAS_DEBUG_WX=3Dy=0ACONFIG_DEBUG_WX=3Dy=0ACONFI=
G_GENERIC_PTDUMP=3Dy=0ACONFIG_PTDUMP_CORE=3Dy=0A# CONFIG_PTDUMP_DEBUGFS i=
s not set=0ACONFIG_DEBUG_OBJECTS=3Dy=0A# CONFIG_DEBUG_OBJECTS_SELFTEST is=
 not set=0A# CONFIG_DEBUG_OBJECTS_FREE is not set=0A# CONFIG_DEBUG_OBJECT=
S_TIMERS is not set=0A# CONFIG_DEBUG_OBJECTS_WORK is not set=0A# CONFIG_D=
EBUG_OBJECTS_RCU_HEAD is not set=0A# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER =
is not set=0ACONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=3D1=0ACONFIG_HAVE_DEBUG_=
KMEMLEAK=3Dy=0A# CONFIG_DEBUG_KMEMLEAK is not set=0A# CONFIG_DEBUG_STACK_=
USAGE is not set=0ACONFIG_SCHED_STACK_END_CHECK=3Dy=0ACONFIG_ARCH_HAS_DEB=
UG_VM_PGTABLE=3Dy=0A# CONFIG_DEBUG_VM is not set=0A# CONFIG_DEBUG_VM_PGTA=
BLE is not set=0ACONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy=0A# CONFIG_DEBUG_VIRTU=
AL is not set=0ACONFIG_DEBUG_MEMORY_INIT=3Dy=0A# CONFIG_DEBUG_PER_CPU_MAP=
S is not set=0ACONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=3Dy=0A# CONFIG_D=
EBUG_KMAP_LOCAL_FORCE_MAP is not set=0ACONFIG_HAVE_ARCH_KASAN=3Dy=0ACONFI=
G_HAVE_ARCH_KASAN_VMALLOC=3Dy=0ACONFIG_CC_HAS_KASAN_GENERIC=3Dy=0ACONFIG_=
CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy=0A# CONFIG_KASAN is not set=0ACONFI=
G_HAVE_ARCH_KFENCE=3Dy=0A# CONFIG_KFENCE is not set=0A# end of Memory Deb=
ugging=0A=0A# CONFIG_DEBUG_SHIRQ is not set=0A=0A#=0A# Debug Oops, Lockup=
s and Hangs=0A#=0A# CONFIG_PANIC_ON_OOPS is not set=0ACONFIG_PANIC_ON_OOP=
S_VALUE=3D0=0ACONFIG_PANIC_TIMEOUT=3D0=0ACONFIG_LOCKUP_DETECTOR=3Dy=0ACON=
FIG_SOFTLOCKUP_DETECTOR=3Dy=0A# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not =
set=0ACONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy=0ACONFIG_HARDLOCKUP_CHECK_TIMES=
TAMP=3Dy=0ACONFIG_HARDLOCKUP_DETECTOR=3Dy=0A# CONFIG_BOOTPARAM_HARDLOCKUP=
_PANIC is not set=0ACONFIG_DETECT_HUNG_TASK=3Dy=0ACONFIG_DEFAULT_HUNG_TAS=
K_TIMEOUT=3D120=0A# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set=0A# CONFI=
G_WQ_WATCHDOG is not set=0A# CONFIG_TEST_LOCKUP is not set=0A# end of Deb=
ug Oops, Lockups and Hangs=0A=0A#=0A# Scheduler Debugging=0A#=0ACONFIG_SC=
HED_DEBUG=3Dy=0ACONFIG_SCHED_INFO=3Dy=0ACONFIG_SCHEDSTATS=3Dy=0A# end of =
Scheduler Debugging=0A=0A# CONFIG_DEBUG_TIMEKEEPING is not set=0ACONFIG_D=
EBUG_PREEMPT=3Dy=0A=0A#=0A# Lock Debugging (spinlocks, mutexes, etc...)=0A=
#=0ACONFIG_LOCK_DEBUGGING_SUPPORT=3Dy=0A# CONFIG_PROVE_LOCKING is not set=
=0A# CONFIG_LOCK_STAT is not set=0A# CONFIG_DEBUG_RT_MUTEXES is not set=0A=
# CONFIG_DEBUG_SPINLOCK is not set=0A# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is =
not set=0A# CONFIG_DEBUG_RWSEMS is not set=0A# CONFIG_DEBUG_LOCK_ALLOC is=
 not set=0A# CONFIG_DEBUG_ATOMIC_SLEEP is not set=0A# CONFIG_DEBUG_LOCKIN=
G_API_SELFTESTS is not set=0A# CONFIG_LOCK_TORTURE_TEST is not set=0A# CO=
NFIG_WW_MUTEX_SELFTEST is not set=0A# CONFIG_SCF_TORTURE_TEST is not set=0A=
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set=0A# end of Lock Debugging (spinlo=
cks, mutexes, etc...)=0A=0ACONFIG_TRACE_IRQFLAGS=3Dy=0ACONFIG_TRACE_IRQFL=
AGS_NMI=3Dy=0A# CONFIG_DEBUG_IRQFLAGS is not set=0ACONFIG_STACKTRACE=3Dy=0A=
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set=0A# CONFIG_DEBUG_KOBJECT is =
not set=0A=0A#=0A# Debug kernel data structures=0A#=0ACONFIG_DEBUG_LIST=3D=
y=0A# CONFIG_DEBUG_PLIST is not set=0A# CONFIG_DEBUG_SG is not set=0A# CO=
NFIG_DEBUG_NOTIFIERS is not set=0ACONFIG_BUG_ON_DATA_CORRUPTION=3Dy=0A# e=
nd of Debug kernel data structures=0A=0A# CONFIG_DEBUG_CREDENTIALS is not=
 set=0A=0A#=0A# RCU Debugging=0A#=0A# CONFIG_RCU_SCALE_TEST is not set=0A=
# CONFIG_RCU_TORTURE_TEST is not set=0A# CONFIG_RCU_REF_SCALE_TEST is not=
 set=0ACONFIG_RCU_CPU_STALL_TIMEOUT=3D21=0ACONFIG_RCU_EXP_CPU_STALL_TIMEO=
UT=3D20=0ACONFIG_RCU_TRACE=3Dy=0A# CONFIG_RCU_EQS_DEBUG is not set=0A# en=
d of RCU Debugging=0A=0A# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set=0A# CON=
FIG_CPU_HOTPLUG_STATE_CONTROL is not set=0ACONFIG_LATENCYTOP=3Dy=0ACONFIG=
_USER_STACKTRACE_SUPPORT=3Dy=0ACONFIG_NOP_TRACER=3Dy=0ACONFIG_HAVE_RETHOO=
K=3Dy=0ACONFIG_RETHOOK=3Dy=0ACONFIG_HAVE_FUNCTION_TRACER=3Dy=0ACONFIG_HAV=
E_FUNCTION_GRAPH_TRACER=3Dy=0ACONFIG_HAVE_DYNAMIC_FTRACE=3Dy=0ACONFIG_HAV=
E_DYNAMIC_FTRACE_WITH_REGS=3Dy=0ACONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_C=
ALLS=3Dy=0ACONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=3Dy=0ACONFIG_HAVE_FTRACE_=
MCOUNT_RECORD=3Dy=0ACONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy=0ACONFIG_HAVE_FEN=
TRY=3Dy=0ACONFIG_HAVE_OBJTOOL_MCOUNT=3Dy=0ACONFIG_HAVE_C_RECORDMCOUNT=3Dy=
=0ACONFIG_HAVE_BUILDTIME_MCOUNT_SORT=3Dy=0ACONFIG_BUILDTIME_MCOUNT_SORT=3D=
y=0ACONFIG_TRACER_MAX_TRACE=3Dy=0ACONFIG_TRACE_CLOCK=3Dy=0ACONFIG_RING_BU=
FFER=3Dy=0ACONFIG_EVENT_TRACING=3Dy=0ACONFIG_CONTEXT_SWITCH_TRACER=3Dy=0A=
CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy=0ACONFIG_PREEMPTIRQ_TRACEPOINTS=3Dy=0AC=
ONFIG_TRACING=3Dy=0ACONFIG_GENERIC_TRACER=3Dy=0ACONFIG_TRACING_SUPPORT=3D=
y=0ACONFIG_FTRACE=3Dy=0A# CONFIG_BOOTTIME_TRACING is not set=0ACONFIG_FUN=
CTION_TRACER=3Dy=0ACONFIG_FUNCTION_GRAPH_TRACER=3Dy=0ACONFIG_DYNAMIC_FTRA=
CE=3Dy=0ACONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy=0ACONFIG_DYNAMIC_FTRACE_WITH=
_DIRECT_CALLS=3Dy=0ACONFIG_DYNAMIC_FTRACE_WITH_ARGS=3Dy=0A# CONFIG_FPROBE=
 is not set=0A# CONFIG_FUNCTION_PROFILER is not set=0ACONFIG_STACK_TRACER=
=3Dy=0ACONFIG_TRACE_PREEMPT_TOGGLE=3Dy=0ACONFIG_IRQSOFF_TRACER=3Dy=0ACONF=
IG_PREEMPT_TRACER=3Dy=0ACONFIG_SCHED_TRACER=3Dy=0ACONFIG_HWLAT_TRACER=3Dy=
=0ACONFIG_OSNOISE_TRACER=3Dy=0ACONFIG_TIMERLAT_TRACER=3Dy=0ACONFIG_MMIOTR=
ACE=3Dy=0ACONFIG_FTRACE_SYSCALLS=3Dy=0ACONFIG_TRACER_SNAPSHOT=3Dy=0ACONFI=
G_TRACER_SNAPSHOT_PER_CPU_SWAP=3Dy=0ACONFIG_BRANCH_PROFILE_NONE=3Dy=0A# C=
ONFIG_PROFILE_ANNOTATED_BRANCHES is not set=0ACONFIG_BLK_DEV_IO_TRACE=3Dy=
=0ACONFIG_KPROBE_EVENTS=3Dy=0A# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not se=
t=0ACONFIG_UPROBE_EVENTS=3Dy=0ACONFIG_BPF_EVENTS=3Dy=0ACONFIG_DYNAMIC_EVE=
NTS=3Dy=0ACONFIG_PROBE_EVENTS=3Dy=0A# CONFIG_BPF_KPROBE_OVERRIDE is not s=
et=0ACONFIG_FTRACE_MCOUNT_RECORD=3Dy=0ACONFIG_FTRACE_MCOUNT_USE_CC=3Dy=0A=
# CONFIG_SYNTH_EVENTS is not set=0A# CONFIG_HIST_TRIGGERS is not set=0A# =
CONFIG_TRACE_EVENT_INJECT is not set=0A# CONFIG_TRACEPOINT_BENCHMARK is n=
ot set=0A# CONFIG_RING_BUFFER_BENCHMARK is not set=0A# CONFIG_TRACE_EVAL_=
MAP_FILE is not set=0A# CONFIG_FTRACE_RECORD_RECURSION is not set=0A# CON=
FIG_FTRACE_STARTUP_TEST is not set=0A# CONFIG_FTRACE_SORT_STARTUP_TEST is=
 not set=0A# CONFIG_RING_BUFFER_STARTUP_TEST is not set=0A# CONFIG_RING_B=
UFFER_VALIDATE_TIME_DELTAS is not set=0A# CONFIG_MMIOTRACE_TEST is not se=
t=0A# CONFIG_PREEMPTIRQ_DELAY_TEST is not set=0A# CONFIG_KPROBE_EVENT_GEN=
_TEST is not set=0A# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set=0A# CONF=
IG_SAMPLES is not set=0ACONFIG_HAVE_SAMPLE_FTRACE_DIRECT=3Dy=0ACONFIG_HAV=
E_SAMPLE_FTRACE_DIRECT_MULTI=3Dy=0ACONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy=0A=
CONFIG_STRICT_DEVMEM=3Dy=0ACONFIG_IO_STRICT_DEVMEM=3Dy=0A=0A#=0A# x86 Deb=
ugging=0A#=0ACONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=3Dy=0A# CONFIG_X86_VERBOSE=
_BOOTUP is not set=0ACONFIG_EARLY_PRINTK=3Dy=0A# CONFIG_EARLY_PRINTK_DBGP=
 is not set=0A# CONFIG_EARLY_PRINTK_USB_XDBC is not set=0A# CONFIG_EFI_PG=
T_DUMP is not set=0A# CONFIG_DEBUG_TLBFLUSH is not set=0A# CONFIG_IOMMU_D=
EBUG is not set=0ACONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy=0A# CONFIG_X86_DECODE=
R_SELFTEST is not set=0A# CONFIG_IO_DELAY_0X80 is not set=0A# CONFIG_IO_D=
ELAY_0XED is not set=0A# CONFIG_IO_DELAY_UDELAY is not set=0ACONFIG_IO_DE=
LAY_NONE=3Dy=0A# CONFIG_DEBUG_BOOT_PARAMS is not set=0A# CONFIG_CPA_DEBUG=
 is not set=0A# CONFIG_DEBUG_ENTRY is not set=0A# CONFIG_DEBUG_NMI_SELFTE=
ST is not set=0A# CONFIG_X86_DEBUG_FPU is not set=0A# CONFIG_PUNIT_ATOM_D=
EBUG is not set=0ACONFIG_UNWINDER_ORC=3Dy=0A# CONFIG_UNWINDER_FRAME_POINT=
ER is not set=0A# end of x86 Debugging=0A=0A#=0A# Kernel Testing and Cove=
rage=0A#=0A# CONFIG_KUNIT is not set=0A# CONFIG_NOTIFIER_ERROR_INJECTION =
is not set=0ACONFIG_FUNCTION_ERROR_INJECTION=3Dy=0ACONFIG_FAULT_INJECTION=
=3Dy=0A# CONFIG_FAILSLAB is not set=0A# CONFIG_FAIL_PAGE_ALLOC is not set=
=0A# CONFIG_FAULT_INJECTION_USERCOPY is not set=0A# CONFIG_FAIL_MAKE_REQU=
EST is not set=0A# CONFIG_FAIL_IO_TIMEOUT is not set=0A# CONFIG_FAIL_FUTE=
X is not set=0A# CONFIG_FAULT_INJECTION_DEBUG_FS is not set=0ACONFIG_ARCH=
_HAS_KCOV=3Dy=0ACONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy=0A# CONFIG_KCOV is not =
set=0ACONFIG_RUNTIME_TESTING_MENU=3Dy=0A# CONFIG_LKDTM is not set=0A# CON=
FIG_TEST_MIN_HEAP is not set=0A# CONFIG_TEST_DIV64 is not set=0A# CONFIG_=
BACKTRACE_SELF_TEST is not set=0A# CONFIG_TEST_REF_TRACKER is not set=0A#=
 CONFIG_RBTREE_TEST is not set=0A# CONFIG_REED_SOLOMON_TEST is not set=0A=
# CONFIG_INTERVAL_TREE_TEST is not set=0A# CONFIG_PERCPU_TEST is not set=0A=
# CONFIG_ATOMIC64_SELFTEST is not set=0A# CONFIG_TEST_HEXDUMP is not set=0A=
# CONFIG_STRING_SELFTEST is not set=0A# CONFIG_TEST_STRING_HELPERS is not=
 set=0A# CONFIG_TEST_STRSCPY is not set=0A# CONFIG_TEST_KSTRTOX is not se=
t=0A# CONFIG_TEST_PRINTF is not set=0A# CONFIG_TEST_SCANF is not set=0A# =
CONFIG_TEST_BITMAP is not set=0A# CONFIG_TEST_UUID is not set=0A# CONFIG_=
TEST_XARRAY is not set=0A# CONFIG_TEST_RHASHTABLE is not set=0A# CONFIG_T=
EST_SIPHASH is not set=0A# CONFIG_TEST_IDA is not set=0A# CONFIG_TEST_LKM=
 is not set=0A# CONFIG_TEST_BITOPS is not set=0A# CONFIG_TEST_VMALLOC is =
not set=0A# CONFIG_TEST_USER_COPY is not set=0A# CONFIG_TEST_BPF is not s=
et=0A# CONFIG_TEST_BLACKHOLE_DEV is not set=0A# CONFIG_FIND_BIT_BENCHMARK=
 is not set=0A# CONFIG_TEST_FIRMWARE is not set=0A# CONFIG_TEST_SYSCTL is=
 not set=0A# CONFIG_TEST_UDELAY is not set=0A# CONFIG_TEST_STATIC_KEYS is=
 not set=0A# CONFIG_TEST_KMOD is not set=0A# CONFIG_TEST_MEMCAT_P is not =
set=0A# CONFIG_TEST_MEMINIT is not set=0A# CONFIG_TEST_FREE_PAGES is not =
set=0A# CONFIG_TEST_FPU is not set=0A# CONFIG_TEST_CLOCKSOURCE_WATCHDOG i=
s not set=0ACONFIG_ARCH_USE_MEMTEST=3Dy=0ACONFIG_MEMTEST=3Dy=0A# end of K=
ernel Testing and Coverage=0A# end of Kernel hacking=0A
--_=__=_XaM3_.1695659445.2A.32770.42.23554.52.42.007.698192834--

