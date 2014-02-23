From: Joel Fernandes <agnel.joel@gmail.com>
Subject: Re: Question on clock drift with NO_HZ_FULL vs NO_HZ_IDLE
Date: Sun, 23 Feb 2014 11:22:44 -0600
Message-ID: <CAD=GYpYGvFCR+rSuH13ciuokuaedy5T_Yi_pdsdmsEM4LrhRHQ@mail.gmail.com>
References: <CAD=GYpaGnS=1A7z6AhtJ9KGH68NY4C5rGRXgfePm33he6s6YOw@mail.gmail.com>
	<20140223163849.GV4250@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org, fweisbec@gmail.com
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:45458 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbaBWRWq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Feb 2014 12:22:46 -0500
Received: by mail-oa0-f42.google.com with SMTP id j17so4271982oag.1
        for <linux-rt-users@vger.kernel.org>; Sun, 23 Feb 2014 09:22:45 -0800 (PST)
In-Reply-To: <20140223163849.GV4250@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Paul,

On Sun, Feb 23, 2014 at 10:38 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Sun, Feb 23, 2014 at 01:20:53AM -0600, Joel Fernandes wrote:
>> Hi,
>> After reading documentation, I follow that NO_HZ_FULL turns off the
>> scheduling-clock interrupt on all except the boot CPU, where as
>> NO_HZ_IDLE turns it off on all idle CPUs.
>>
>> I understand the period scheduling-clock interrupt is required to
>> compensate for hardware oscillator drift. I believe that's why
>> NO_HZ_FULL keeps it ON on atleast one CPU. That way the drift is
>> compensated for.
>>
>> But, with NO_HZ_IDLE, all CPUs turn off interrupt during idle. Then
>> how is the drift accounted for?
>>
>> CC'ing Paul as well for any guidance, thanks :)
>
> The clock code fixes things up as needed when the first CPU returns
> from idle.

Thanks a lot for your reply. It makes sense to me now. Also, thanks
for the great talk at LCA. :)

regards,
-Joel
