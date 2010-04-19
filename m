From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: Strange behavior of pthread_setaffinity_np
Date: Mon, 19 Apr 2010 17:31:59 +0530
Message-ID: <y2y921ca19c1004190501xdd8506a3j3f4337caf272c55c@mail.gmail.com>
References: <z2hc5b2c05b1004190245od92c276n6933d75f9d4d2669@mail.gmail.com>
	 <j2r921ca19c1004190407zc167abddp4944c46e81fd95fc@mail.gmail.com>
	 <p2zc5b2c05b1004190451x906bd2dehefaded5b8108ced7@mail.gmail.com>
	 <w2n921ca19c1004190501n36c7f10ch484cda701e261ee9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: RT <linux-rt-users@vger.kernel.org>
To: Primiano Tucci <p.tucci@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f182.google.com ([209.85.221.182]:64970 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab0DSMCD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Apr 2010 08:02:03 -0400
Received: by qyk12 with SMTP id 12so5144860qyk.21
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Apr 2010 05:02:01 -0700 (PDT)
In-Reply-To: <w2n921ca19c1004190501n36c7f10ch484cda701e261ee9@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Apr 19, 2010 at 5:31 PM, Sujit K M <sjt.kar@gmail.com> wrote:
> On Mon, Apr 19, 2010 at 5:21 PM, Primiano Tucci <p.tucci@gmail.com> wrote:
>> Hi Sujit,
>> thanks for your reply, but I have not completely understood your point.
>> Does the kernel make (from the thread viewpoint) differences between
>> Cores of a Processor, or multiple processors?
>
> Yes, It certainly does for Kernel Level Routines. But on User level
> Applications,
> These Might not be the case.
>
>> In my previous speak I generally used the term CPU #0 and #1 to refer
>> to two different cores of a same Processor (a quad core Q9550).
>
> What I had in mind for Quad was Four Cores per Processors.
>
>> Do you mean I need a different API to sett affinity on a per-core
>> basis rather than a per-processor basis? It sound strange to me, as in
>> my little knowledge Cores are viewed, by the system, as different
>> processor, just as in the case of a regular Multi Processor system.
>
> I donot think these API's Have been developed.
>



-- 
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
