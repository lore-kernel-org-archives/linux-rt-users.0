From: "Jayabrata Chakrabarty" <jayabrata.chakrabarty@gmail.com>
Subject: Realfeel benchmark tool
Date: Thu, 5 Jul 2007 23:57:47 +1000
Message-ID: <3df244bc0707050657i730de682n7b9ac7c2fa57d058@mail.gmail.com>
References: <3df244bc0707050655h6a0bfabcrb6e1ad51ad50b5c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:4081 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757794AbXGEN5s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Jul 2007 09:57:48 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1856920nze
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Jul 2007 06:57:48 -0700 (PDT)
In-Reply-To: <3df244bc0707050655h6a0bfabcrb6e1ad51ad50b5c1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Everyone,

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
