From: "Samuel Ortiz" <samuel@sortiz.org>
Subject: Re: [irda-users] [2.6.20-rt8] "Neighbour table overflow."
Date: 16 Mar 2007 16:45:41 -0000
Message-ID: <gd3M42Jr.1174063541.4027990.samuel@sortiz.org>
References: <xzU03ang.1174063266.3162320.samuel@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "irda-users@lists.sourceforge.net" <irda-users@lists.sourceforge.net>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: gl@dsa-ac.de, mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 25.mail-out.ovh.net ([213.186.37.103]:41821 "HELO
	25.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753582AbXCPQp6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Mar 2007 12:45:58 -0400
In-Reply-To: <xzU03ang.1174063266.3162320.samuel@sortiz.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Here you go, Ingo:

 Index: net/irda/irttp.c
===================================================================
RCS file: /home/dsa/cvs/linux-2_6/net/irda/irttp.c,v
retrieving revision 1.1.1.11
diff -u -r1.1.1.11 irttp.c
--- a/net/irda/irttp.c 5 Mar 2007 13:18:59 -0000 1.1.1.11
+++ b/net/irda/irttp.c 16 Mar 2007 11:04:31 -0000
@@ -1455,6 +1468,7 @@

/* Not everything should be copied */
new->notify.instance = instance;
+ spin_lock_init(&new->lock);
init_timer(&new->todo_timer);

skb_queue_head_init(&new->rx_queue);


On 3/16/2007, "Samuel Ortiz" <samuel@sortiz.org> wrote:

>
>Reply from Ingo, got mistakenly discarded by the irda-users mailing list:
>
>* Guennadi Liakhovetski <gl@dsa-ac.de> wrote:
>
>> > could you send the patch for that? Is it upstream already?
>>
>> It's indeed an IrDA bug (though mainly visible under rt-preempt) and
>> the patch has been sent to the maintainer and to stable.
>
>could you please bounce it to me too? I usually put such patches into
>-rt straight away and i drop them when they show up upstream.
>
>Ingo
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
