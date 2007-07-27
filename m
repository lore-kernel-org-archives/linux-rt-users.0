From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: Threaded IPIs?
Date: Fri, 27 Jul 2007 07:56:34 +0300
Message-ID: <46A97B02.6090806@qumranet.com>
References: <46A8F6F70200005A000283D4@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory Haskins <ghaskins-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46A8F6F70200005A000283D4-Igcdv/6uVdMHoYOw/+koYqIwWpluYiW7@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Gregory Haskins wrote:
> Hi guys,
>   While working with the -rt kernel, I have noticed a problem in KVM.
> Specifically, when you stop a VM you sometimes get a "sleep while
> atomic" oopses.  It turns out that the issue is related to an
> smp_function_call IPI that KVM does to remotely flush the VMX hardware
> on shutdown.  The code tries to acquire the global kvm_lock (which is a
> normal spinlock_t, of course converted to rt_mutex on -rt) from the
> interrupt context of the IPI handler.  You know the rest of the
> story....
>
> The obvious solution is to convert the kvm_lock to a raw_spinlock_t.
> However, I really don't want to do this unless we absolutely have to
> since it will just increase latencies for a good portion of the rest of
> KVM.
>   

Are you talking about decache_vcpus_from_cpu() that is called from
hardware_disable()?  Would having the caller acquire the lock solve the
problem?  Then it would be acquired from outside the IPI.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
