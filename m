From: Vladimir Cotfas <vladc@mantatest.com>
Subject: Latency Problems with 2.6.31/PREEMPT_RT on a 1.2GHz Celeron
Date: Fri, 18 Dec 2009 11:56:58 -0500
Message-ID: <4B2BB45A.9040909@mantatest.com>
References: <abe060d60912171537j10fe194r5f0cd1aca85475df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080209030103040304090707"
Cc: Scott Gilbertson <scottg@mantatest.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39397 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbZLRQ6F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Dec 2009 11:58:05 -0500
Received: by yxe17 with SMTP id 17so3070110yxe.33
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Dec 2009 08:58:00 -0800 (PST)
In-Reply-To: <abe060d60912171537j10fe194r5f0cd1aca85475df@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080209030103040304090707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

All,

I have a a driver that must process an interrupt every 100 uS without 
missing any. I am having latency issues and I am looking for some help 
debugging my problem.

I am using a TME 5831 motherboard (VIA TwisterT chipset) with a custom 
BIOS. The SMBIOS is disabled.

I prepared a minimalistic kernel (configuration file attached) that uses 
a ramdisk for the apps (as to limit the scope of the latency problem). 
It has no disk(s) or network drivers. I use tty0 console and a serial 
console.

The IRQ is fired every 100 uS. The ISR for this takes typically 30 uS to 
execute and does some PCI transfers with the hardware. The typical 
latency between IRQ-assert and the execution of the ISR is about 12 uS. 
However sometimes IRQs for my hardware are lost or delayed.

While doing some instrumentation and using the kernel latency tracers I 
noticed that the scheduler sometimes take a long time to execute (50+ 
uS, with spikes to 99 uS).
 
I instrumented handle_irq() (see irq_32.diff) to take the time stamps 
before & after executing the ISR handlers. The time stamps are kept in 
some global arrays (which are exported as symbols). A utility module 
(irq_time.c) exports this to user-space via /proc/irq_time.

I did a run in which my custom driver is not loaded.  The file 
report.txt (attached) shows the cpu info, the IRQ list (the timer 
interrupt is 0).  The dump of /proc/irq_time has histograms which show 
that the timer interrupt has a sensible number of occurrences that 
gravitate around 55 uS. I managed to cause these high numbers by running 
this script:
    while :; do cat /proc/nonexistent; done
on the tty0 console.

I need to understand whether this is caused by my setup or it's 
something to be expected from the scheduler/timer interrupt.

Regards,
Vlad



--------------080209030103040304090707
Content-Type: text/plain;
 name="report.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="report.txt"

cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 11
model name	: Intel(R) Celeron(TM) CPU                1200MHz
stepping	: 4
cpu MHz		: 1202.732
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pse36 mmx fxsr sse
bogomips	: 2405.46
clflush size	: 32
power management:

$ cat /proc/sched_debug 
Sched Debug Version: v0.09, 2.6.31.5-pae #40
now at 569878.550195 msecs
  .jiffies                                 : 26987
  .sysctl_sched_latency                    : 20.000000
  .sysctl_sched_min_granularity            : 4.000000
  .sysctl_sched_wakeup_granularity         : 5.000000
  .sysctl_sched_child_runs_first           : 0.000001
  .sysctl_sched_features                   : 113917

cpu#0, 1202.732 MHz
  .nr_running                    : 2
  .load                          : 2048
  .nr_switches                   : 166477
  .nr_load_updates               : 56987
  .nr_uninterruptible            : 0
  .next_balance                  : 0.000000
  .curr->pid                     : 10247
  .clock                         : 569876.819824
  .cpu_load[0]                   : 0
  .cpu_load[1]                   : 0
  .cpu_load[2]                   : 0
  .cpu_load[3]                   : 0
  .cpu_load[4]                   : 0
  .rt.rt_nr_running              : 0
  .rt.rt_nr_uninterruptible      : 4294967295
  .rto_schedule                  : 0
  .rto_schedule_tail             : 0
  .rto_wakeup                    : 0
  .rto_pulled                    : 0
  .rto_pushed                    : 0
  .yld_count                     : 0
  .sched_switch                  : 0
  .sched_count                   : 166492
  .sched_goidle                  : 53938
  .ttwu_count                    : 0
  .ttwu_local                    : 0
  .bkl_count                     : 113

cfs_rq[0]:
  .exec_clock                    : 33842.569082
  .MIN_vruntime                  : 109488.040579
  .min_vruntime                  : 109478.039924
  .max_vruntime                  : 109488.040579
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 2
  .load                          : 2048
  .nr_spread_over                : 0

rt_rq[0]:
  .rt_nr_running                 : 0
  .rt_throttled                  : 0
  .rt_time                       : 0.244658
  .rt_runtime                    : 950.000000

runnable tasks:
            task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
----------------------------------------------------------------------------------------------------------
              sh    94    109488.040579      1368   120    109488.040579        76.460871    565643.825364
R            cat 10247    109478.039924         0   120    109478.039924         0.000000         0.000000

$ cat /proc/schedstat 
version 15
timestamp 27327
cpu0 0 0 167641 54449 0 0 34327664830 27532065207 113177
$ cat /proc/interrupts 
           CPU0       
  0:      57955    XT-PIC-XT        timer
  1:         46    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  4:       4062    XT-PIC-XT        serial
  8:          0    XT-PIC-XT        rtc
 12:          3    XT-PIC-XT        i8042
NMI:          0   Non-maskable interrupts
TRM:          0   Thermal event interrupts
MCE:          0   Machine check exceptions
MCP:          2   Machine check polls
ERR:          0

$ cat /proc/irq_time 
 IRQ 	count	avg usS	max uS
  0 	58634	11	89
  1 	46	6	25
  4 	4123	18	30
 12 	3	9	10
 IRQ 	usS	count
  0 	7	6
  0 	8	54032
  0 	9	907
  0 	10	201
  0 	11	34
  0 	12	25
  0 	13	13
  0 	14	11
  0 	15	4
  0 	16	3
  0 	17	1
  0 	18	7
  0 	20	2
  0 	21	3
  0 	22	3
  0 	23	1
  0 	29	4
  0 	30	2
  0 	31	4
  0 	32	7
  0 	33	5
  0 	34	19
  0 	35	22
  0 	36	23
  0 	37	23
  0 	38	33
  0 	39	32
  0 	40	44
  0 	41	47
  0 	42	56
  0 	43	76
  0 	44	93
  0 	45	148
  0 	46	184
  0 	47	133
  0 	48	148
  0 	49	114
  0 	50	92
  0 	51	83
  0 	52	77
  0 	53	86
  0 	54	66
  0 	55	63
  0 	56	61
  0 	57	70
  0 	58	101
  0 	59	99
  0 	60	123
  0 	61	211
  0 	62	294
  0 	63	312
  0 	64	212
  0 	65	100
  0 	66	51
  0 	67	11
  0 	68	7
  0 	69	2
  0 	70	2
  0 	71	5
  0 	72	5
  0 	73	6
  0 	74	3
  0 	75	5
  0 	76	2
  0 	77	6
  0 	79	3
  0 	82	1
  0 	85	1
  0 	87	1
  0 	88	2
  0 	89	1
 IRQ 	usS	count
  1 	5	39
  1 	6	2
  1 	7	2
  1 	18	1
  1 	20	1
  1 	25	1
 IRQ 	usS	count
  4 	5	557
  4 	6	156
  4 	7	74
  4 	8	122
  4 	9	73
  4 	10	45
  4 	11	39
  4 	12	79
  4 	13	97
  4 	14	174
  4 	15	180
  4 	16	132
  4 	17	162
  4 	18	154
  4 	19	121
  4 	20	171
  4 	21	104
  4 	22	90
  4 	23	119
  4 	24	187
  4 	25	179
  4 	26	195
  4 	27	298
  4 	28	425
  4 	29	178
  4 	30	12
 IRQ 	usS	count
 12 	8	1
 12 	9	1
 12 	10	1

--------------080209030103040304090707
Content-Type: application/x-gzip;
 name="config-rt-100Hz.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config-rt-100Hz.gz"

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
Nl8o+x8memU/2E4AAA==
--------------080209030103040304090707
Content-Type: application/octet-stream;
 name="irq_32.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="irq_32.diff"

LS0tIGFyY2gveDg2L2tlcm5lbC9pcnFfMzIuYy5vcmlnCTIwMDktMTAtMjIgMTg6NTc6NTYu
MDAwMDAwMDAwIC0wNDAwCisrKyBhcmNoL3g4Ni9rZXJuZWwvaXJxXzMyLmMJMjAwOS0xMi0x
NyAxNzozNTozMi4wMDAwMDAwMDAgLTA1MDAKQEAgLTE5Miw2ICsxOTIsNDEgQEAKIGV4ZWN1
dGVfb25faXJxX3N0YWNrKGludCBvdmVyZmxvdywgc3RydWN0IGlycV9kZXNjICpkZXNjLCBp
bnQgaXJxKSB7IHJldHVybiAwOyB9CiAjZW5kaWYKIAorI2RlZmluZSBNQVhfVFJBQ0VEX0xB
VEVOQ1kgMTAwCisjaWZkZWYgTUFYX1RSQUNFRF9MQVRFTkNZCisgICNkZWZpbmUgUFJPQ19N
SFogMTIwMgorI2VuZGlmCisKKy8vIERlYyAxMSwgMjAwOSB1bGlhbm92IC0gdGltZSBJUlFz
Cit2b2xhdGlsZSB1MzIgaXJxX2NvdW50W05SX1ZFQ1RPUlNdID0gezB9OworRVhQT1JUX1NZ
TUJPTChpcnFfY291bnQpOworCit2b2xhdGlsZSB1NjQgaXJxX3RvdGFsX3RpbWVbTlJfVkVD
VE9SU10gPSB7MH07CitFWFBPUlRfU1lNQk9MKGlycV90b3RhbF90aW1lKTsKKwordm9sYXRp
bGUgdTY0IGlycV9tYXhfdGltZVtOUl9WRUNUT1JTXSA9IHswfTsKK0VYUE9SVF9TWU1CT0wo
aXJxX21heF90aW1lKTsKKworI2lmZGVmIE1BWF9UUkFDRURfTEFURU5DWQordm9sYXRpbGUg
dTY0IGlycV9tYXhfdGltZV92ZWNbTlJfVkVDVE9SU11bTUFYX1RSQUNFRF9MQVRFTkNZKzFd
OworRVhQT1JUX1NZTUJPTChpcnFfbWF4X3RpbWVfdmVjKTsKKyNlbmRpZgorCisvLyNkZWZp
bmUgUFVMU0VfQ0FMTEJBQ0sKKyNpZmRlZiBQVUxTRV9DQUxMQkFDSworc3RhdGljIHZvaWQg
KCpwdWxzZV9jYmspKHVuc2lnbmVkIGlycSwgaW50IHN0YXRlLCB2b2lkKiBmdW5jKTsKK3N0
YXRpYyBERUZJTkVfQVRPTUlDX1NQSU5MT0NLKHB1bHNlX2Nia19sb2NrKTsKKwordm9pZCBp
cnFfc2V0X3B1bHNlX2Niayh2b2lkICgqaGFuZGxlcikodW5zaWduZWQgaXJxLCBpbnQgc3Rh
dGUsIHZvaWQqIGZ1bmMpKQoreworCXUzMiBmbGFncyA9IDA7CisJYXRvbWljX3NwaW5fbG9j
a19pcnFzYXZlKCZwdWxzZV9jYmtfbG9jaywgZmxhZ3MpOworCXB1bHNlX2NiayA9IGhhbmRs
ZXI7CisJYXRvbWljX3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnB1bHNlX2Nia19sb2NrLCBm
bGFncyk7Cit9CitFWFBPUlRfU1lNQk9MKGlycV9zZXRfcHVsc2VfY2JrKTsKKyNlbmRpZiAv
LyBQVUxTRV9DQUxMQkFDSworCiBib29sIGhhbmRsZV9pcnEodW5zaWduZWQgaXJxLCBzdHJ1
Y3QgcHRfcmVncyAqcmVncykKIHsKIAlzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2M7CkBAIC0yMDYs
NyArMjQxLDM3IEBACiAJaWYgKCFleGVjdXRlX29uX2lycV9zdGFjayhvdmVyZmxvdywgZGVz
YywgaXJxKSkgewogCQlpZiAodW5saWtlbHkob3ZlcmZsb3cpKQogCQkJcHJpbnRfc3RhY2tf
b3ZlcmZsb3coKTsKKworI2lmZGVmIFBVTFNFX0NBTExCQUNLCisJCWlmKHB1bHNlX2NiayAh
PSBOVUxMKSB7CisJCQlhdG9taWNfc3Bpbl9sb2NrKCZwdWxzZV9jYmtfbG9jayk7CisJCQlp
ZihwdWxzZV9jYmsgIT0gTlVMTCkgcHVsc2VfY2JrKGlycSwgMSwgJmhhbmRsZV9pcnEpOwor
CQkJYXRvbWljX3NwaW5fdW5sb2NrKCZwdWxzZV9jYmtfbG9jayk7CisgICAgICAgICAgICAg
ICAgfQorI2VuZGlmIC8vIFBVTFNFX0NBTExCQUNLCisJCS8vIERlYyAxMSwgMjAwOSB1bGlh
bm92IC0gdGltZSBJUlFzCisJCXU2NCB0cyA9IGdldF9jeWNsZXMoKTsKIAkJZGVzYy0+aGFu
ZGxlX2lycShpcnEsIGRlc2MpOworCQl1NjQgdGUgPSBnZXRfY3ljbGVzKCk7CisjaWZkZWYg
UFVMU0VfQ0FMTEJBQ0sKKwkJaWYocHVsc2VfY2JrICE9IE5VTEwpIHsKKwkJCWF0b21pY19z
cGluX2xvY2soJnB1bHNlX2Nia19sb2NrKTsKKwkJCWlmKHB1bHNlX2NiayAhPSBOVUxMKSBw
dWxzZV9jYmsoaXJxLCAwLCAmaGFuZGxlX2lycSk7CisJCQlhdG9taWNfc3Bpbl91bmxvY2so
JnB1bHNlX2Nia19sb2NrKTsKKyAgICAgICAgICAgICAgICB9CisjZW5kaWYgLy8gUFVMU0Vf
Q0FMTEJBQ0sKKwkJaWYodGUgPj0gdHMpIHsgLy8gdGhlIFRTQyBkaWQgbm90IG92ZXJmbG93
CisJCQl1NjQgZFQgPSB0ZSAtIHRzOworCQkJaXJxX2NvdW50W2lycV0rKzsKKwkJCWlycV90
b3RhbF90aW1lW2lycV0gKz0gZFQ7CisJCQlpZihkVCA+IGlycV9tYXhfdGltZVtpcnFdKSBp
cnFfbWF4X3RpbWVbaXJxXSA9IGRUOworI2lmZGVmIE1BWF9UUkFDRURfTEFURU5DWQorCQkJ
ZG9fZGl2KGRULCBQUk9DX01IWik7CisJCQlpZihkVCA8IE1BWF9UUkFDRURfTEFURU5DWSkK
KwkJCSAgICAgaXJxX21heF90aW1lX3ZlY1tpcnFdWyhpbnQpZFRdKys7CisJCQllbHNlIGly
cV9tYXhfdGltZV92ZWNbaXJxXVtNQVhfVFJBQ0VEX0xBVEVOQ1ldKys7CisjZW5kaWYKKyAg
ICAgICAgICAgICAgICB9CiAJfQogCiAJcmV0dXJuIHRydWU7Cg==
--------------080209030103040304090707
Content-Type: application/octet-stream;
 name="irq_time.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="irq_time.c"

I2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgojaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CiNp
bmNsdWRlIDxsaW51eC9jcHVmcmVxLmg+CiNpbmNsdWRlIDxsaW51eC9wcm9jX2ZzLmg+ICAg
ICAgLy8gZm9yIHRoZSBwcm9jIGZpbGVzeXN0ZW0KCiNkZWZpbmUgTlJfVkVDVE9SUwkyNTYK
Ci8vIGRlZmluZWQgaW4gYXJjaC94ODYva2VybmVsL2lycV8zMi5jCmV4dGVybiB2b2xhdGls
ZSB1MzIgaXJxX2NvdW50W05SX1ZFQ1RPUlNdOwpleHRlcm4gdm9sYXRpbGUgdTY0IGlycV90
b3RhbF90aW1lW05SX1ZFQ1RPUlNdOwpleHRlcm4gdm9sYXRpbGUgdTY0IGlycV9tYXhfdGlt
ZVtOUl9WRUNUT1JTXTsKCiNkZWZpbmUgTUFYX1RSQUNFRF9MQVRFTkNZIDEwMAojaWZkZWYg
TUFYX1RSQUNFRF9MQVRFTkNZCmV4dGVybiB2b2xhdGlsZSB1NjQgaXJxX21heF90aW1lX3Zl
Y1tOUl9WRUNUT1JTXVtNQVhfVFJBQ0VEX0xBVEVOQ1krMV07CiNlbmRpZgoKc3RhdGljIHUz
MiBwcm9jZXNzb3JNZWdhaGVydHo7CgpzdGF0aWMgc3RydWN0IHByb2NfZGlyX2VudHJ5KiBw
cm9jRmlsZUVudHJ5OwoKI2RlZmluZSBTVEFUSUNfQlVGX0xFTiA1MDAwMAoKc3RhdGljIGlu
dCBwcm9jZmlsZV9yZWFkKGNoYXIqIGJ1ZmZlcl9VTlVTRUQsIGNoYXIqKiBzdGFydCwKICAg
ICAgICAgICAgICAgICAgICAgICAgIG9mZl90IG9mZnNldCwgaW50IGNvdW50LAogICAgICAg
ICAgICAgICAgICAgICAgICAgaW50KiBlb2YsIHZvaWQqIGRhdGEpCnsKICBzdGF0aWMgaW50
IGxlbiA9IDA7CiAgc3RhdGljIGNoYXIgc19idWZbU1RBVElDX0JVRl9MRU5dID0gezB9Owog
IGNvbnN0IGludCBidWZfY250ID0gU1RBVElDX0JVRl9MRU4gLSAxOwogIGNoYXIqIGJ1ZiA9
IHNfYnVmOwogIGludCBpcnEgPSAwOwoKICBpZihvZmZzZXQgPiAwKSB7CiAgICAqc3RhcnQg
PSBzX2J1ZiArIG9mZnNldDsKICAgICplb2YgPSAobGVuID49IG9mZnNldCkgPyAwIDogMTsK
ICAgIHJldHVybiBlb2YgPyAobGVuIC0gb2Zmc2V0KSA6IDA7CiAgfQoKICBsZW4gPSAwOwoK
ICBsZW4gKz0gc25wcmludGYoYnVmICsgbGVuLCBidWZfY250IC0gbGVuIC0gMSwgIiBJUlEg
XHRjb3VudFx0YXZnIHVzU1x0bWF4IHVTXG4iKTsKCiAgZm9yKGlycSA9IDA7IGlycSA8IE5S
X1ZFQ1RPUlM7IGlycSsrKSB7CiAgICB1NjQgbWF4X2RpdiA9IGlycV9tYXhfdGltZVtpcnFd
OwogICAgaWYobWF4X2RpdiA9PSAwKSBjb250aW51ZTsKCiAgICB1MzIgY250ID0gaXJxX2Nv
dW50W2lycV07CiAgICB1NjQgdG90YWwgPSBpcnFfdG90YWxfdGltZVtpcnFdOwogICAgdTY0
IGF2Z19kaXYgPSAwOwogICAgaWYoY250ICE9IDApIHsKICAgICAgZG9fZGl2KHRvdGFsLCBj
bnQpOwogICAgICBhdmdfZGl2ID0gdG90YWw7CiAgICAgIGRvX2RpdihhdmdfZGl2LCBwcm9j
ZXNzb3JNZWdhaGVydHopOyAvLyBUUklDSyEhIGRpdiBpcyBtb2RpZmllZCwgcmV0dXJucyBy
ZW1pbmRlcgogICAgfQoKICAgIGRvX2RpdihtYXhfZGl2LCBwcm9jZXNzb3JNZWdhaGVydHop
OyAvLyBUUklDSyEhIGRpdiBpcyBtb2RpZmllZCwgcmV0dXJucyByZW1pbmRlcgoKICAgIGxl
biArPSBzbnByaW50ZihidWYgKyBsZW4sIGJ1Zl9jbnQgLSBsZW4gLSAxLCAiJTNkIFx0JWx1
XHQlbGx1XHQlbGx1XG4iLCBpcnEsIGNudCwgYXZnX2RpdiwgbWF4X2Rpdik7CiAgfQogCiNp
ZmRlZiBNQVhfVFJBQ0VEX0xBVEVOQ1kKICBmb3IoaXJxID0gMDsgaXJxIDwgTlJfVkVDVE9S
UzsgaXJxKyspIHsKICAgIHUzMiBsYXQgPSAwOwogICAgaWYoaXJxX2NvdW50W2lycV0gPT0g
MCkgY29udGludWU7CgogICAgbGVuICs9IHNucHJpbnRmKGJ1ZiArIGxlbiwgYnVmX2NudCAt
IGxlbiAtIDEsICIgSVJRIFx0dXNTXHRjb3VudFxuIik7CgogICAgZm9yKGxhdCA9IDA7IGxh
dCA8PSBNQVhfVFJBQ0VEX0xBVEVOQ1k7IGxhdCsrKSB7CiAgICAgIHUzMiB0aW1lID0gaXJx
X21heF90aW1lX3ZlY1tpcnFdW2xhdF07CiAgICAgIGlmKHRpbWUgPT0gMCkgY29udGludWU7
CgogICAgICBsZW4gKz0gc25wcmludGYoYnVmICsgbGVuLCBidWZfY250IC0gbGVuIC0gMSwg
IiUzZCBcdCVsdVx0JWx1XG4iLCBpcnEsIGxhdCwgdGltZSk7CiAgICB9CiAgfQojZW5kaWYg
Ly8gTUFYX1RSQUNFRF9MQVRFTkNZCgogICpzdGFydCA9IHNfYnVmICsgb2Zmc2V0OwogICpl
b2YgPSAobGVuID49IG9mZnNldCkgPyAwIDogMTsKICByZXR1cm4gZW9mID8gKGxlbiAtIG9m
ZnNldCkgOiAwOwp9CgpzdGF0aWMgaW50IF9faW5pdCBpcnFfdGltZV9pbml0KHZvaWQpCnsK
ICB1bnNpZ25lZCBpbnQgZnJlcSA9IDA7CgojaWZkZWYgQ09ORklHX0NQVV9GUkVRCiAgZnJl
cSA9IGNwdWZyZXFfZ2V0KDAgLypjcHUqLyk7IC8vIGluIGtIeiEKI2VuZGlmCgogIGlmKGZy
ZXEgPT0gMCkKICAgIGZyZXEgPSBjcHVfa2h6OwoKICBmcmVxIC89IDEwMDA7CgogIHByb2Nl
c3Nvck1lZ2FoZXJ0eiA9IGZyZXE7CgogIGlmKHByb2Nlc3Nvck1lZ2FoZXJ0eiA8PSAwKSBy
ZXR1cm4gLUVJTzsKCiAgcHJvY0ZpbGVFbnRyeSA9IGNyZWF0ZV9wcm9jX3JlYWRfZW50cnko
CiAgICAgICAgICAgICAgICAgICAgICAgICJpcnFfdGltZSIsCiAgICAgICAgICAgICAgICAg
ICAgICAgIFNfSUZSRUcgfCBTX0lSVUdPLAogICAgICAgICAgICAgICAgICAgICAgICBOVUxM
LCAgIC8qIGJhc2UgZW50cnkgKi8KICAgICAgICAgICAgICAgICAgICAgICAgcHJvY2ZpbGVf
cmVhZCwgIC8qIHJlYWQgb3BlcmF0aW9uICovCiAgICAgICAgICAgICAgICAgICAgICAgIE5V
TEwgICAgLyogZGF0YSAqLwogICAgICAgICAgICAgICAgICApOwogIGlmKHByb2NGaWxlRW50
cnkgPT0gTlVMTCkgcmV0dXJuIC1FTk9NRU07CgogIHJldHVybiAwOwp9Cm1vZHVsZV9pbml0
KGlycV90aW1lX2luaXQpOwoKc3RhdGljIHZvaWQgX19leGl0IGlycV90aW1lX2NsZWFudXAo
dm9pZCkKewogIHJlbW92ZV9wcm9jX2VudHJ5KHByb2NGaWxlRW50cnktPm5hbWUsIHByb2NG
aWxlRW50cnktPnN1YmRpcik7Cn0KbW9kdWxlX2V4aXQoaXJxX3RpbWVfY2xlYW51cCk7CgpN
T0RVTEVfTElDRU5TRSgiR1BMIik7Cg==
--------------080209030103040304090707--
