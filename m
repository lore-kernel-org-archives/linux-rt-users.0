Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:42806 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728201AbeHNXZl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 19:25:41 -0400
Date: Tue, 14 Aug 2018 15:36:21 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH 09/15] squashfs: make use of local lock in multi_cpu
 decompressor
Message-ID: <20180814203621.GA9506@jcartwri.amer.corp.natinst.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
 <37654199e62d7092f0da75e87841dfe82dda483f.1534263273.git.tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37654199e62d7092f0da75e87841dfe82dda483f.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tom Zanussi <zanussi@kernel.org>
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com

Hey Tom-

On Tue, Aug 14, 2018 at 01:54:02PM -0500, Tom Zanussi wrote:
> v3.18.117-rt105 rt-stable review patch.  If anyone has any objections,
> please let me know.
> 
> ------------------
> 
> From: Julia Cartwright <julia@ni.com>
> 
> [ Upstream rt-devel commit c160736542d7b3d67da32848d2f028b8e35730e5 ]
> 
> Currently, the squashfs multi_cpu decompressor makes use of
> get_cpu_ptr()/put_cpu_ptr(), which unconditionally disable preemption
> during decompression.
> 
> Because the workload is distributed across CPUs, all CPUs can observe a
> very high wakeup latency, which has been seen to be as much as 8000us.
> 
> Convert this decompressor to make use of a local lock, which will allow
> execution of the decompressor with preemption-enabled, but also ensure
> concurrent accesses to the percpu compressor data on the local CPU will
> be serialized.
> 
> Cc: stable-rt@vger.kernel.org
> Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
> Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
> Signed-off-by: Julia Cartwright <julia@ni.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
[..]
>  void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
>  						void *comp_opts)
>  {
> @@ -79,10 +82,15 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
>  {
>  	struct squashfs_stream __percpu *percpu =
>  			(struct squashfs_stream __percpu *) msblk->stream;
> -	struct squashfs_stream *stream = get_cpu_ptr(percpu);
> -	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
> -		offset, length, output);
> -	put_cpu_ptr(stream);
> +	struct squashfs_stream *stream;
> +	int res;
> +
> +	stream = get_locked_ptr(stream_lock, percpu);

This patch depends on the introduction of the {get,put}_locked_ptr()
per-cpu access variants.  So, you'll want to also pull commit

 3d45cf23db4f76cd3 ("locallock: provide {get,put}_locked_ptr() variants")

>From rt-devel as well.

  Julia
