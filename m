From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [RFC][PATCH 5/3] tracing: Add smi counting to HWLAT
Date: Tue, 9 Aug 2016 15:28:57 -0300
Message-ID: <81075ecf-90c3-fdb2-59eb-defd215af2eb@redhat.com>
References: <20160804145708.158968389@goodmis.org>
 <20160809140543.2e5c83b5@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33222 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257AbcHIS3E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Aug 2016 14:29:04 -0400
Received: by mail-qk0-f175.google.com with SMTP id t7so21397899qkh.0
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Aug 2016 11:29:03 -0700 (PDT)
In-Reply-To: <20160809140543.2e5c83b5@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/09/2016 03:05 PM, Steven Rostedt wrote:
> If an arch supports counting of SMIs (like newer intel chips do), then it
> can implement arch_smi_count() to return the number of SMIs that were
> triggered. The hwlat detector will call this function to get the current
> number of SMIs, and then after a period, it will read that function again,
> and if there's a difference, it will record that into the sample.
> 
> For example:
> 
>  [99] inner:13 outer:16 ts:1470352534.886878855
>  [100] inner:14 outer:18747 ts:1470352538.917966818 smi-count:2
>  [101] inner:0 outer:19162 ts:1470352539.920988709 smi-count:6
>  [102] inner:19376 outer:19276 ts:1470352540.923010578 smi-count:6
>  [103] inner:19650 outer:20665 ts:1470352541.926032469 smi-count:6
>  [104] inner:20526 outer:20680 ts:1470352542.973055312 smi-count:6
>  [105] inner:17 outer:17 ts:1470352543.990077507
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

It worked fine in a system that I can manually cause SMIs (by turning
keyboard's backlight on and off).

Tested-by: Daniel Bristot de Oliveira <bristot@redhat.com>

-- Daniel
