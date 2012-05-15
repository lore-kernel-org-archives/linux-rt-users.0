From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH 2/2] V3: cyclictest: report large measured clock latency
Date: Tue, 15 May 2012 16:44:37 -0700
Message-ID: <4FB2EA65.7010101@am.sony.com>
References: <4FB2E868.4070802@am.sony.com> <4FB2E94E.6080008@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "dvhart@linux.intel.com" <dvhart@linux.intel.com>,
	"lclaudio@uudg.org" <lclaudio@uudg.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:58765
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932842Ab2EOXpS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 19:45:18 -0400
In-Reply-To: <4FB2E94E.6080008@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/15/12 16:39, Frank Rowand wrote:
> 
> V3: Use src/lib/error.c functions instead of fprintf.
>     Fix printf format warnings for 32 bit vs 64 bit systems with cast.

One issue with using warn() and info() instead of fprintf() is that
the compiler no longer warns about format mismatches.  Just an FYI...


>     Fix bad continuation line white space prefix.
>     Remove unused variable zero_diff.
> 

< snip >

