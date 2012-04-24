From: Mark Hounschell <dmarkh@cfl.rr.com>
Subject: Re: Hard real time in user space with preempt_rt patch
Date: Tue, 24 Apr 2012 04:57:32 -0400
Message-ID: <4F966AFC.7070803@cfl.rr.com>
References: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com>
Reply-To: dmarkh@cfl.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Anisha Kaul <born.rebel.83@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:32521 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632Ab2DXI5e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Apr 2012 04:57:34 -0400
In-Reply-To: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/24/2012 01:46 AM, Anisha Kaul wrote:
> From: https://rt.wiki.kernel.org/articles/f/r/e/Frequently_Asked_Questions_7407.html
>
>> Real-time only has impact on the kernel; Userspace does not notice the difference except for better real time behavior.
>
> Does it mean that if we write the applications in user space, they
> won't get the hard real time effect?
> The threads running in the userspace won't get the hard real time effect?
>

You use the term "hard real time". The RT patch set does not even come 
close to providing a "hard real time" environment, and isn't even 
attempting to. It does however provide user land applications a much better 
chance for a "soft real time" environment. The phrase you quot above just 
means the patches are applied to the kernel and there are no patches 
required for user land glibc or your application.

Regards
Mark
