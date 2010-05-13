From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Differnce between kthread and worqueue ?
Date: Thu, 13 May 2010 10:12:32 +0200
Message-ID: <4BEBB470.9040501@gmail.com>
References: <AANLkTik5vq9XHP4eCYw2J4eZVf3pwJZGP_9C4T93otAs@mail.gmail.com> <4BEBB413.9010404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: ratheesh k <ratheesh.ksz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:25669 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab0EMIMf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 May 2010 04:12:35 -0400
In-Reply-To: <4BEBB413.9010404@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/13/2010 10:10 AM, Jiri Slaby wrote:
> On 05/13/2010 09:25 AM, ratheesh k wrote:
>> What is the real difference between these ? . I know that workqueue
>> run on process context and can sleep ..what about kthread ?
> 
> Well, workqueue runs in a kthread called name_of_your_workqueue/cpu
> ("/cpu" is omitted when singlethread wq). 

(And when you use just schedule_work and create no workqueue for
yourself, it's "events/cpu" kthread.)

-- 
js
