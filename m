From: Monica Puig-Pey <puigpeym@unican.es>
Subject: How to use plist.h in the rt-path?
Date: Mon, 11 Jul 2011 14:09:39 +0200
Message-ID: <4E1AE803.2030904@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi there,

As I told in previous posts in this list I'm developing drivers for the
linux-rt kernel version in Ubuntu 10.04, based on 2.6.31 with rt_preemp=
t=20
patch.

Currently I'm studying how to use priority lists (linux/plist.h) in a=20
module. I read some pages from the Linux Kernel Development book to=20
learn how linked list work in the kernel.

I made and easy example, shown below, trying to put three elements, wit=
h=20
their priorities, in a plist_head.

Then, I had two problems:

* First error:

   An error is produced when using the MACROs:
     - PLIST_HEAD_INIT(head, _lock)
     - PLIST_NODE_INIT(node, __prio)

   it says :

        /home/monica/Escritorio/plists/priolist.c: In function=20
'init_module':
        /home/monica/Escritorio/plists/priolist.c:67: error: expected=20
expression before '.' token


   --> To solve this I used the functions:

          - static inline void plist_head_init(struct plist_head *head,=
=20
struct spinlock *lock)

          - static inline void plist_node_init(struct plist_node *node,=
=20
int prio)

   But I still have the problem with the MACRO




* Second error, problem using plist_add:

   It says:

    =93WARNING: "plist_add" [/home/monica/Escritorio/plists/priolist.ko=
]=20
undefined! =94

   I made the module GPL, I don't know what am I doing wrong.

Does anybody have an idea what is happening?

Thanks in advance for any help,

Cheers,

         Monica

CODE:

#include <linux/module.h>=09
#include <linux/kernel.h>
#include <linux/ioport.h>
#include <linux/plist.h>
#include <linux/spinlock.h>


MODULE_LICENSE("GPL");

#define pid_miguel 1
#define fichero_miguel 1
#define prio_miguel 10


#define pid_monica 2
#define fichero_monica 1
#define prio_monica 30

#define pid_hector 3
#define fichero_hector 1
#define prio_hector 20



static DEFINE_SPINLOCK(lock);


struct misdatos
{
   int pid;
   int fichero;
   struct plist_node token_del_plist;
};


int init_module(void)
{


   struct plist_head mi_lista_de_datos;
   //struct spinlock lock;
   struct misdatos datos_miguel;
   struct misdatos datos_monica;
   struct misdatos datos_hector;

   struct misdatos *elemento_iterador;

   // Inicializo mi lista
   //PLIST_HEAD_INIT( mi_lista_de_datos, lock);
   plist_head_init( &mi_lista_de_datos, &lock);

   // Creo mis datos
   datos_miguel.pid =3D pid_miguel;
   datos_miguel.fichero =3D fichero_miguel;

   datos_monica.pid =3D pid_monica;
   datos_monica.fichero =3D fichero_monica;

   datos_hector.pid =3D pid_hector;
   datos_hector.fichero =3D fichero_hector;

   // Inicializamos los nodos CON LA PRIORIDAD
   //PLIST_NODE_INIT(datos_miguel.token_del_plist, prio_miguel);
   //PLIST_NODE_INIT(datos_monica.token_del_plist, prio_monica);
   //PLIST_NODE_INIT(datos_hector.token_del_plist, prio_hector);
   plist_node_init(&datos_miguel.token_del_plist, prio_miguel);
   plist_node_init(&datos_monica.token_del_plist, prio_monica);
   plist_node_init(&datos_hector.token_del_plist, prio_hector);


   // Los agnadimos
   plist_add(&(datos_miguel.token_del_plist), &mi_lista_de_datos);
   plist_add(&(datos_monica.token_del_plist), &mi_lista_de_datos);
   plist_add(&(datos_hector.token_del_plist), &mi_lista_de_datos);



   plist_for_each_entry(elemento_iterador, &mi_lista_de_datos,=20
token_del_plist)
   {
       printk(KERN_INFO "El pid es : %d, con prioridad %d\n",=20
elemento_iterador->pid, elemento_iterador->token_del_plist.prio);
   }
   return 0;
}

void cleanup_module(void)
{
printk(KERN_INFO "cleanup_module() called\n");

}
