From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v2] slub: Keep page and object in sync in
 slab_alloc_node()
Date: Mon, 21 Jan 2013 07:19:42 -0500
Message-ID: <1358770782.23981.8.camel@gandalf.local.home>
References: <1358458996.23211.46.camel@gandalf.local.home>
	 <0000013c4a7e7fbf-c51fd42a-2455-4fec-bb37-915035956f05-000000@email.amazonses.com>
	 <1358462763.23211.57.camel@gandalf.local.home>
	 <1358464245.23211.62.camel@gandalf.local.home>
	 <1358464837.23211.66.camel@gandalf.local.home>
	 <1358468598.23211.67.camel@gandalf.local.home>
	 <1358468924.23211.69.camel@gandalf.local.home>
	 <0000013c4e1ea131-b8ab56b9-bfca-44fe-b5da-f030551194c9-000000@email.amazonses.com>
	 <1358521484.7383.8.camel@gandalf.local.home>
	 <1358524501.7383.17.camel@gandalf.local.home>
	 <20130121081121.GA3936@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Pekka Enberg <penberg@kernel.org>, Matt Mackall <mpm@selenic.com>, Thomas
 Gleixner <tglx@linutronix.de>, RT <linux-rt-users@vger.kernel.org>, Clark
 Williams <clark@redhat.com>, John Kacur <jkacur@gmail.com>, "Luis Claudio
 R. Goncalves" <lgoncalv@redhat.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130121081121.GA3936@lge.com>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-01-21 at 17:11 +0900, Joonsoo Kim wrote:

> Hello.
> I have one stupid question just for curiosity.
> Does the processor re-order instructions which load data from same cacheline?
> 

Probably not, but I wouldn't have generic code assuming cacheline sizes.

-- Steve



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
