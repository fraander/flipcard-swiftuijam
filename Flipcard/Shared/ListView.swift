//
//  ListView.swift
//  Flipcard
//
//  Created by Frank on 11/6/21.
//

import SwiftUI

struct ListView: View {
	@Binding var view: Int
	
	@FetchRequest(
		entity: CD_Card.entity(),
		sortDescriptors: [
			//			NSSortDescriptor(keyPath: \CD_Card._term, ascending: true),
			//			NSSortDescriptor(keyPath: \CD_Card._definition, ascending: true),
			//			NSSortDescriptor(keyPath: \CD_Card.objectID, ascending: true)
		]
	) var allCards: FetchedResults<CD_Card>
	
	@State var editViewCard: CD_Card? = nil
	
    var body: some View {
		VStack(spacing: 0) {
			NavigationHeader(newCardAction: {}, view: $view)
			#if os(iOS)
				.padding(.bottom)
			#endif
			
			#if os(macOS)
			
			Text("Your cards")
				.font(.largeTitle)
				.bold()
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding()
			
			Divider()
			
			#endif

			List {
				ForEach(allCards) {card in
					HStack {
						VStack(alignment: .leading) {
							Text(card._term)
								.font(.headline)
							Text(card._definition)
								.font(.subheadline)
								.foregroundColor(.secondary)
						}
						
						Spacer()
						
						Button {
							editViewCard = card
						} label: {
							Image(systemName: "info.circle")
								.foregroundColor(.orange)
						}
						
					}
					#if os(macOS)
					.padding(.top, 10)
					#endif
				}
				.onDelete { offsets in
					CoreDataHelper.deleteItems(offsets: offsets, cards: allCards)
				}
#if os(macOS)
				.padding(.leading)
#endif
			}
			.listStyle(.plain)
			
			if allCards.count == 0 {
				VStack(alignment: .center) {
					
					(
						Text("Tap ") + Text("\(Image(systemName: "plus")) New Card") .bold() + Text(" to add a card.")
					)
						.font(.caption)
					
					Spacer()
				}
			}
		}
		.sheet(item: $editViewCard) {
			//
		} content: { card in
			EditView(editViewCard: $editViewCard)
				.frame(width: 300)
		}
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}
