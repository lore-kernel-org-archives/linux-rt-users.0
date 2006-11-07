From: "Gerhard Olsson" <gerhard.nospam@gmail.com>
Subject: Re: 2.6.18-rt7 oops at boot
Date: Wed, 8 Nov 2006 00:19:58 +0100
Message-ID: <d4209ca0611071519k1085522dv1770ea966d94fb8a@mail.gmail.com>
References: <d4209ca0611070519o1539a6f1ye6f6393ec87b37e2@mail.gmail.com>
	 <200611071321.53274.dvhltc@us.ibm.com>
	 <d4209ca0611071509q17b4230w599c9c37f2f733eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:53281 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1753867AbWKGXUA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Nov 2006 18:20:00 -0500
Received: by nf-out-0910.google.com with SMTP id o25so432391nfa
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Nov 2006 15:19:59 -0800 (PST)
To: linux-rt-users@vger.kernel.org
In-Reply-To: <d4209ca0611071509q17b4230w599c9c37f2f733eb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

A clarification: hpet is enabled in the kernel config

The url for testing the timing:
http://lkml.org/lkml/2005/11/2/164

On 11/8/06, Gerhard Olsson <gerhard.nospam@gmail.com> wrote:
> There are no "hpet" clocksource (and no acpi, as these are disabled in kernel):
