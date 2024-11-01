// 크루 목록 출력
var showPage = 1;
var cnt = 15;
var vPages = 10;

const searchParams = new URLSearchParams(window.location.search);
var searchType = searchParams.get('searchType');
var keywords = searchParams.get('keywords');

pageShow(showPage);

function pageShow(page) {
    $.ajax({
        type: 'post',
        url: 'crew_list.ajax',
        data: {
            'page': page,
            'cnt': cnt,
            'opt': searchType,
            'keyword': keywords
        },
        dataType: 'json',
        success: function(data) {
            listPrint(data.list, data.totalIdx, data.currentPage, data.offset);
            $('#pagination').twbsPagination({
                startPage: data.page,
                totalPages: data.totalPages,
                visiblePages: vPages,
                onPageClick: function(evt, page) {
                    pageShow(page);
                }
            });
            document.getElementsByClassName('first')[0].children[0].innerHTML = '<i class="bi bi-chevron-bar-left"></i>';
            document.getElementsByClassName('prev')[0].children[0].innerHTML = '<i class="bi bi-chevron-left"></i>';
            document.getElementsByClassName('next')[0].children[0].innerHTML = '<i class="bi bi-chevron-right"></i>';
            document.getElementsByClassName('last')[0].children[0].innerHTML = '<i class="bi bi-chevron-bar-right"></i>';
        },
        error: function(e) {}
    });
}

function listPrint(list, totalIdx, currentPage, offset) {
    let tags = '';

    for (let i = 0; i < list.length; i++) {
        tags += '<tr>';
        tags += '<td>'+(totalIdx - ( (currentPage - 1) * cnt) - i)+'</td>';
        tags += '<td class="left">';
        tags += '<a href="admin_crewDetail.go?crew_idx='+list[i].crew_idx+'">';
        tags += list[i].name;
        tags += '</a></td>';
        tags += '<td>'+list[i].crew_id+' ('+list[i].nick+')</td>';
        tags += '<td>'+list[i].region_name+' '+list[i].regions_name+'</td>';
        tags += '<td>'+list[i].cnt_members+'</td>';
        tags += '<td>'+list[i].create_date+'</td>';
        tags += '<td>'+list[i].last_date+'</td>';
        if (list[i].status){
            tags += '<td><button class="mainbtn minbtn">운영중</button></td>';
        } else {
            tags += '<td><button class="subbtn minbtn">운영종료</button></td>';
        }
        tags += '</tr>';
    }
    document.getElementsByTagName('tbody')[0].innerHTML = tags;
}