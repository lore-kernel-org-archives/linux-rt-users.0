From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH] kexec: reenable HPET before kexec
Date: Mon, 27 Aug 2007 11:26:29 -0700
Message-ID: <653FFBB4508B9042B5D43DC9E18836F501522051@scsmsx415.amr.corp.intel.com>
References: <20070820205530.1ffd5876@windmill.dev.rtsoft.ru> <20070823090845.GA13065@in.ibm.com> <20070823154936.3b7ae498@windmill.dev.rtsoft.ru> <20070827053656.GC9809@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "RT" <linux-rt-users@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Andi Kleen" <ak@suse.de>
To: <vgoyal@in.ibm.com>,
	"Konstantin Baydarov" <kbaidarov@ru.mvista.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759615AbXH0S0o@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20070827053656.GC9809@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


>
>I think we should dive little deeper to find out the root 
>cause of the problem
>instead of putting the intermediate patch. These timer issues 
>are tricky
>ones and we have already solved few of these.
>
>Going back to your original mail where you specify root cause.
>
>- You mentioned that first kernel disables HPET while enabling 
>Local APIC
>timer. Can you please point me when exactly it happens. I had 
>thought local
>APIC timer and HPET server different purpose and co-exist.
>
>- You also mentioned that kernel tries to setup PIT as it does not find
>HPET in second kernel. Where exactly does it do that? I think 
>we need to
>then go deeper to find out why PIT is not working now? Is it 
>disabled? or
>LAPIC/IOAPIC have not been setup properly and PIT interrupts 
>never reach
>CPU? 
>

- Another thing to try is to disable HPET and boot with PIT in the first
kernel. Just to check whether PIT never works on this platform or the
first kernel is doing something to stop PIT. You can try "hpet=disable"
boot option for that.

Thanks,
Venki
