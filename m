From: "Samuel Ortiz" <samuel@sortiz.org>
Subject: Re: [irda-users] [2.6.20-rt8] "Neighbour table overflow."
Date: 16 Mar 2007 16:23:18 -0000
Message-ID: <BPfiEnM7.1174062198.0464040.samuel@sortiz.org>
References: <20070316161653.GC9413@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "irda-users@lists.sourceforge.net" <irda-users@lists.sourceforge.net>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: mingo@elte.hu, gl@dsa-ac.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 25.mail-out.ovh.net ([213.186.37.103]:38854 "HELO
	25.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753566AbXCPQXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Mar 2007 12:23:35 -0400
In-Reply-To: <20070316161653.GC9413@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hi Ingo,

On 3/16/2007, "Ingo Molnar" <mingo@elte.hu> wrote:

>
>* Guennadi Liakhovetski <gl@dsa-ac.de> wrote:
>
>> Hi
>>
>> After fixing the irda spinlock init bug, [...]
>
>could you send the patch for that? Is it upstream already?
Guennadi sent it to me earlier this afternoon. I will forward it upstream
later today.

Cheers,
Samuel.


>> user.warn kernel: Neighbour table overflow.
>
>hm, i havent seen this one yet.
>
>	Ingo
>
>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share your
>opinions on IT & business topics through brief surveys-and earn cash
>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>_______________________________________________
>irda-users mailing list
>irda-users@lists.sourceforge.net
>http://lists.sourceforge.net/lists/listinfo/irda-users
