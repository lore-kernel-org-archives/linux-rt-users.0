From: "Jayabrata Chakrabarty" <jayabrata.chakrabarty@gmail.com>
Subject: Interrupt latency
Date: Sat, 7 Jul 2007 00:08:55 +1000
Message-ID: <3df244bc0707060708l33ece5b8l4a4241e7343fdd69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:5287 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbXGFOI4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2007 10:08:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so278694wah
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Jul 2007 07:08:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello All,

I have a query, Can i use Realfeel benchmark tool,
to test the interrupt latency on an smp machine. I have a non-smp machine,
on which i tested the 2.6.19-rt11 kernel, and i got very impressive
interrupt latency (< 30 us, with tests carried over 10 hours, on heavy load).
But i am not getting the same performance on an smp machine, which i
recently acquired. I used the latest 2.6.21.5-rt19 kernel.
But still the same results. Am i doing something wrong, or is Realfeel not
meant for smp? In that case, which tool can i use? I have used the Realfeel
tool from the amlat package.

Regards
Jayabrata
