From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance  tracking
Date: Tue, 23 Oct 2012 12:59:05 -0700
Message-ID: <C34CF7BC-7050-4050-B15B-6E9A1F5DA327@thebigcorporation.com>
References: <1802256036.5241288.1351020331171.JavaMail.root@redhat.com> <5086F64C.20802@am.sony.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: John Kacur <jkacur@redhat.com>, Bhavesh Davda <bhavesh@vmware.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>
To: <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36468 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945Ab2JWT7L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2012 15:59:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so682278pbb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Oct 2012 12:59:11 -0700 (PDT)
In-Reply-To: <5086F64C.20802@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Oct 23, 2012, at 12:55 PM, Frank Rowand <frank.rowand@am.sony.com> wrote:

> On 10/23/12 12:25, John Kacur wrote:
>> 
> 
> < snip >
> 
>> Let's not overdo it here, I've actually already added these patches
>> in my private repo. I only want to hear if there are functional
>> problems. I'm wondering if this is fine with histograms by default or
>> if we want to protect it with an option? Or do we need to add
>> something to make it easy to filter out?
> 
> OK.  I'll apply the patches, test the result, and do a review.\

At one point the overflows were already being tracked.

In any case it is helpful along with the max to adjust the histogram range and buckets as needed.

Sven

