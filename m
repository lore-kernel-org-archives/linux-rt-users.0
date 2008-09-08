From: "Karthik Singaram Lakshmanan" <karthiksingaram@gmail.com>
Subject: Re: Question regarding sched_setaffinity
Date: Mon, 8 Sep 2008 10:40:01 -0400
Message-ID: <1ca41c0f0809080740s20aadd48wa9486ce08f766e40@mail.gmail.com>
References: <1ca41c0f0808312012v4c52576cw307929992781eeca@mail.gmail.com>
	 <alpine.DEB.1.10.0809051523270.23959@gandalf.stny.rr.com>
	 <48C190CC.10400@compro.net>
	 <alpine.DEB.1.10.0809051642200.31439@gandalf.stny.rr.com>
	 <48C51A63.1070700@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:2709 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbYIHOkE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Sep 2008 10:40:04 -0400
Received: by ti-out-0910.google.com with SMTP id b6so937919tic.23
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Sep 2008 07:40:01 -0700 (PDT)
In-Reply-To: <48C51A63.1070700@compro.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks for all your prompt replies. I really appreciate your help. I
was able to build some test programs to verify the behavior, I wanted
to make sure that I am not missing any corner cases. In my target
scenario, we do not consider taking CPUs offline, therefore
sched_setaffinity works perfectly fine.

Thanks,
Karthik
